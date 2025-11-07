using System;
using System.Collections.Generic;
using Bloomie.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace Bloomie.Data;

public partial class BloomieContext : DbContext
{
    public BloomieContext(DbContextOptions<BloomieContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AspNetRole> AspNetRoles { get; set; }

    public virtual DbSet<AspNetRoleClaim> AspNetRoleClaims { get; set; }

    public virtual DbSet<AspNetUser> AspNetUsers { get; set; }

    public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; }

    public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; }

    public virtual DbSet<AspNetUserToken> AspNetUserTokens { get; set; }

    public virtual DbSet<Batch> Batches { get; set; }

    public virtual DbSet<BatchFlowerType> BatchFlowerTypes { get; set; }

    public virtual DbSet<CartItem> CartItems { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<ChatConversation> ChatConversations { get; set; }

    public virtual DbSet<ChatMessage> ChatMessages { get; set; }

    public virtual DbSet<CustomArrangement> CustomArrangements { get; set; }

    public virtual DbSet<CustomArrangementFlower> CustomArrangementFlowers { get; set; }

    public virtual DbSet<FlowerType> FlowerTypes { get; set; }

    public virtual DbSet<FlowerTypeProduct> FlowerTypeProducts { get; set; }

    public virtual DbSet<InventoryTransaction> InventoryTransactions { get; set; }

    public virtual DbSet<Message> Messages { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<OrderStatusHistory> OrderStatusHistories { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<PresentationStyle> PresentationStyles { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductImage> ProductImages { get; set; }

    public virtual DbSet<Promotion> Promotions { get; set; }

    public virtual DbSet<Rating> Ratings { get; set; }

    public virtual DbSet<Reply> Replies { get; set; }

    public virtual DbSet<Report> Reports { get; set; }

    public virtual DbSet<Shipping> Shippings { get; set; }

    public virtual DbSet<ShoppingCart> ShoppingCarts { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    public virtual DbSet<UserAccessLog> UserAccessLogs { get; set; }

    public virtual DbSet<UserLike> UserLikes { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AspNetRole>(entity =>
        {
            entity.HasIndex(e => e.NormalizedName, "RoleNameIndex")
                .IsUnique()
                .HasFilter("([NormalizedName] IS NOT NULL)");

            entity.Property(e => e.Name).HasMaxLength(256);
            entity.Property(e => e.NormalizedName).HasMaxLength(256);
        });

        modelBuilder.Entity<AspNetRoleClaim>(entity =>
        {
            entity.HasIndex(e => e.RoleId, "IX_AspNetRoleClaims_RoleId");

            entity.HasOne(d => d.Role).WithMany(p => p.AspNetRoleClaims).HasForeignKey(d => d.RoleId);
        });

        modelBuilder.Entity<AspNetUser>(entity =>
        {
            entity.HasIndex(e => e.NormalizedEmail, "EmailIndex");

            entity.HasIndex(e => e.NormalizedUserName, "UserNameIndex")
                .IsUnique()
                .HasFilter("([NormalizedUserName] IS NOT NULL)");

            entity.Property(e => e.Email).HasMaxLength(256);
            entity.Property(e => e.NormalizedEmail).HasMaxLength(256);
            entity.Property(e => e.NormalizedUserName).HasMaxLength(256);
            entity.Property(e => e.UserName).HasMaxLength(256);

            entity.HasMany(d => d.Roles).WithMany(p => p.Users)
                .UsingEntity<Dictionary<string, object>>(
                    "AspNetUserRole",
                    r => r.HasOne<AspNetRole>().WithMany().HasForeignKey("RoleId"),
                    l => l.HasOne<AspNetUser>().WithMany().HasForeignKey("UserId"),
                    j =>
                    {
                        j.HasKey("UserId", "RoleId");
                        j.ToTable("AspNetUserRoles");
                        j.HasIndex(new[] { "RoleId" }, "IX_AspNetUserRoles_RoleId");
                    });
        });

        modelBuilder.Entity<AspNetUserClaim>(entity =>
        {
            entity.HasIndex(e => e.UserId, "IX_AspNetUserClaims_UserId");

            entity.HasOne(d => d.User).WithMany(p => p.AspNetUserClaims).HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<AspNetUserLogin>(entity =>
        {
            entity.HasKey(e => new { e.LoginProvider, e.ProviderKey });

            entity.HasIndex(e => e.UserId, "IX_AspNetUserLogins_UserId");

            entity.HasOne(d => d.User).WithMany(p => p.AspNetUserLogins).HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<AspNetUserToken>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.LoginProvider, e.Name });

            entity.HasOne(d => d.User).WithMany(p => p.AspNetUserTokens).HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<Batch>(entity =>
        {
            entity.HasIndex(e => e.SupplierId, "IX_Batches_SupplierId");

            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Supplier).WithMany(p => p.Batches).HasForeignKey(d => d.SupplierId);
        });

        modelBuilder.Entity<BatchFlowerType>(entity =>
        {
            entity.HasKey(e => new { e.BatchId, e.FlowerTypeId });

            entity.HasIndex(e => e.FlowerTypeId, "IX_BatchFlowerTypes_FlowerTypeId");

            entity.HasOne(d => d.Batch).WithMany(p => p.BatchFlowerTypes).HasForeignKey(d => d.BatchId);

            entity.HasOne(d => d.FlowerType).WithMany(p => p.BatchFlowerTypes).HasForeignKey(d => d.FlowerTypeId);
        });

        modelBuilder.Entity<CartItem>(entity =>
        {
            entity.HasIndex(e => e.CartId, "IX_CartItems_CartId");

            entity.HasIndex(e => e.ProductId, "IX_CartItems_ProductId");

            entity.Property(e => e.DiscountedPrice).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Cart).WithMany(p => p.Items).HasForeignKey(d => d.CartId);

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasIndex(e => e.ParentCategoryId, "IX_Categories_ParentCategoryId");

            entity.HasOne(d => d.ParentCategory).WithMany(p => p.SubCategories).HasForeignKey(d => d.ParentCategoryId);
        });

        modelBuilder.Entity<ChatConversation>(entity =>
        {
            entity.HasIndex(e => e.UserId, "IX_ChatConversations_UserId");

            entity.Property(e => e.Title).HasMaxLength(200);

            // Ignore this configuration - ApplicationDbContext handles ChatConversation relationships
            // entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<ChatMessage>(entity =>
        {
            entity.HasIndex(e => e.ConversationId, "IX_ChatMessages_ConversationId");

            entity.Property(e => e.Role).HasMaxLength(10);

            entity.HasOne(d => d.Conversation).WithMany(p => p.ChatMessages).HasForeignKey(d => d.ConversationId);
        });

        modelBuilder.Entity<CustomArrangement>(entity =>
        {
            entity.HasIndex(e => e.PresentationStyleId, "IX_CustomArrangements_PresentationStyleId");

            entity.HasIndex(e => e.UserId, "IX_CustomArrangements_UserId");

            entity.Property(e => e.BasePrice).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.FlowersCost).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.PresentationStyle).WithMany(p => p.CustomArrangements)
                .HasForeignKey(d => d.PresentationStyleId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<CustomArrangementFlower>(entity =>
        {
            entity.HasIndex(e => e.CustomArrangementId, "IX_CustomArrangementFlowers_CustomArrangementId");

            entity.HasIndex(e => e.FlowerTypeId, "IX_CustomArrangementFlowers_FlowerTypeId");

            entity.Property(e => e.TotalPrice).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.CustomArrangement).WithMany(p => p.CustomArrangementFlowers).HasForeignKey(d => d.CustomArrangementId);

            entity.HasOne(d => d.FlowerType).WithMany(p => p.CustomArrangementFlowers)
                .HasForeignKey(d => d.FlowerTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<FlowerType>(entity =>
        {
            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

            entity.HasMany(d => d.Suppliers).WithMany(p => p.FlowerTypes)
                .UsingEntity<Dictionary<string, object>>(
                    "FlowerTypeSupplier",
                    r => r.HasOne<Supplier>().WithMany().HasForeignKey("SuppliersId"),
                    l => l.HasOne<FlowerType>().WithMany().HasForeignKey("FlowerTypesId"),
                    j =>
                    {
                        j.HasKey("FlowerTypesId", "SuppliersId");
                        j.ToTable("FlowerTypeSuppliers");
                        j.HasIndex(new[] { "SuppliersId" }, "IX_FlowerTypeSuppliers_SuppliersId");
                    });
        });

        modelBuilder.Entity<FlowerTypeProduct>(entity =>
        {
            entity.HasKey(e => new { e.FlowerTypeId, e.ProductId });

            entity.HasIndex(e => e.ProductId, "IX_FlowerTypeProducts_ProductId");

            entity.HasOne(d => d.FlowerType).WithMany(p => p.FlowerTypeProducts).HasForeignKey(d => d.FlowerTypeId);

            entity.HasOne(d => d.Product).WithMany(p => p.FlowerTypeProducts).HasForeignKey(d => d.ProductId);
        });

        modelBuilder.Entity<InventoryTransaction>(entity =>
        {
            entity.HasIndex(e => e.BatchId, "IX_InventoryTransactions_BatchId");

            entity.HasIndex(e => e.FlowerTypeId, "IX_InventoryTransactions_FlowerTypeId");

            entity.HasIndex(e => e.OrderId, "IX_InventoryTransactions_OrderId");

            entity.HasIndex(e => e.ProductId, "IX_InventoryTransactions_ProductId");

            entity.HasIndex(e => e.SupplierId, "IX_InventoryTransactions_SupplierId");

            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Batch).WithMany().HasForeignKey(d => d.BatchId);

            entity.HasOne(d => d.FlowerType).WithMany().HasForeignKey(d => d.FlowerTypeId);

            entity.HasOne(d => d.Order).WithMany().HasForeignKey(d => d.OrderId);

            entity.HasOne(d => d.Product).WithMany(p => p.InventoryTransactions).HasForeignKey(d => d.ProductId);

            entity.HasOne(d => d.Supplier).WithMany().HasForeignKey(d => d.SupplierId);
        });

        modelBuilder.Entity<Message>(entity =>
        {
            entity.HasIndex(e => e.ReceiverId, "IX_Messages_ReceiverId");

            entity.HasIndex(e => e.SenderId, "IX_Messages_SenderId");

            entity.HasOne(d => d.Receiver).WithMany()
                .HasForeignKey(d => d.ReceiverId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Sender).WithMany()
                .HasForeignKey(d => d.SenderId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasIndex(e => e.UserId, "IX_Notifications_UserId");

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasIndex(e => e.PromotionId, "IX_Orders_PromotionId");

            entity.HasIndex(e => e.UserId, "IX_Orders_UserId");

            entity.Property(e => e.TotalPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Promotion).WithMany().HasForeignKey(d => d.PromotionId);

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasIndex(e => e.OrderId, "IX_OrderDetails_OrderId");

            entity.HasIndex(e => e.ProductId, "IX_OrderDetails_ProductId");

            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails).HasForeignKey(d => d.OrderId);

            entity.HasOne(d => d.Product).WithMany().HasForeignKey(d => d.ProductId);
        });

        modelBuilder.Entity<OrderStatusHistory>(entity =>
        {
            entity.HasIndex(e => e.OrderId, "IX_OrderStatusHistories_OrderId");

            entity.HasOne(d => d.Order).WithMany().HasForeignKey(d => d.OrderId);
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasIndex(e => e.OrderId, "IX_Payments_OrderId").IsUnique();

            entity.Property(e => e.Amount).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Order).WithOne(p => p.Payment).HasForeignKey<Payment>(d => d.OrderId);
        });

        modelBuilder.Entity<PresentationStyle>(entity =>
        {
            entity.Property(e => e.BasePrice).HasColumnType("decimal(18, 2)");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasIndex(e => e.CategoryId, "IX_Products_CategoryId");

            entity.HasIndex(e => e.PresentationStyleId, "IX_Products_PresentationStyleId");

            entity.Property(e => e.DiscountPercentage).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Category).WithMany(p => p.Products).HasForeignKey(d => d.CategoryId);

            entity.HasOne(d => d.PresentationStyle).WithMany(p => p.Products).HasForeignKey(d => d.PresentationStyleId);
        });

        modelBuilder.Entity<ProductImage>(entity =>
        {
            entity.HasIndex(e => e.ProductId, "IX_ProductImages_ProductId");

            entity.HasOne(d => d.Product).WithMany(p => p.Images).HasForeignKey(d => d.ProductId);
        });

        modelBuilder.Entity<Promotion>(entity =>
        {
            entity.Property(e => e.DiscountPercentage).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.MaximumDiscountValue).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.MinimumOrderValue).HasColumnType("decimal(18, 2)");
        });

        modelBuilder.Entity<Rating>(entity =>
        {
            entity.HasIndex(e => e.ProductId, "IX_Ratings_ProductId");

            entity.HasIndex(e => e.UserId, "IX_Ratings_UserId");

            entity.HasOne(d => d.Product).WithMany(p => p.Ratings).HasForeignKey(d => d.ProductId);

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<Reply>(entity =>
        {
            entity.HasIndex(e => e.RatingId, "IX_Replies_RatingId");

            entity.HasIndex(e => e.UserId, "IX_Replies_UserId");

            entity.HasOne(d => d.Rating).WithMany(p => p.Replies)
                .HasForeignKey(d => d.RatingId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<Report>(entity =>
        {
            entity.HasIndex(e => e.RatingId, "IX_Reports_RatingId");

            entity.HasIndex(e => e.ReporterId, "IX_Reports_ReporterId");

            entity.HasOne(d => d.Rating).WithMany(p => p.Reports)
                .HasForeignKey(d => d.RatingId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Reporter).WithMany().HasForeignKey(d => d.ReporterId);
        });

        modelBuilder.Entity<Shipping>(entity =>
        {
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");
        });

        modelBuilder.Entity<ShoppingCart>(entity =>
        {
            entity.HasKey(e => e.CartId);
        });

        modelBuilder.Entity<UserAccessLog>(entity =>
        {
            entity.HasIndex(e => e.UserId, "IX_UserAccessLogs_UserId");

            entity.HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId);
        });

        modelBuilder.Entity<UserLike>(entity =>
        {
            entity.HasIndex(e => e.RatingId, "IX_UserLikes_RatingId");

            entity.HasIndex(e => e.ReplyId, "IX_UserLikes_ReplyId");

            entity.HasIndex(e => e.UserId, "IX_UserLikes_UserId");

            entity.HasOne(d => d.Rating).WithMany(p => p.UserLikes).HasForeignKey(d => d.RatingId);

            entity.HasOne(d => d.Reply).WithMany(p => p.UserLikes)
                .HasForeignKey(d => d.ReplyId)
                .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
