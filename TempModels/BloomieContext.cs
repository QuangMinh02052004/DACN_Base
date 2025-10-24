using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Bloomie.TempModels;

public partial class BloomieContext : DbContext
{
    public BloomieContext()
    {
    }

    public BloomieContext(DbContextOptions<BloomieContext> options)
        : base(options)
    {
    }

    public virtual DbSet<FlowerType> FlowerTypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectionStrings:DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<FlowerType>(entity =>
        {
            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
