using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bloomie.Migrations
{
    /// <inheritdoc />
    public partial class FixChatConversationUserFK : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ChatConversations_AspNetUser_AspNetUserId",
                table: "ChatConversations");

            migrationBuilder.DropForeignKey(
                name: "FK_ChatConversations_AspNetUser_UserId",
                table: "ChatConversations");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomArrangements_AspNetUser_AspNetUserId",
                table: "CustomArrangements");

            migrationBuilder.DropForeignKey(
                name: "FK_Messages_AspNetUser_AspNetUserId",
                table: "Messages");

            migrationBuilder.DropForeignKey(
                name: "FK_Messages_AspNetUser_AspNetUserId1",
                table: "Messages");

            migrationBuilder.DropForeignKey(
                name: "FK_Notifications_AspNetUser_AspNetUserId",
                table: "Notifications");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_AspNetUser_AspNetUserId",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Ratings_AspNetUser_AspNetUserId",
                table: "Ratings");

            migrationBuilder.DropForeignKey(
                name: "FK_Replies_AspNetUser_AspNetUserId",
                table: "Replies");

            migrationBuilder.DropForeignKey(
                name: "FK_Reports_AspNetUser_AspNetUserId",
                table: "Reports");

            migrationBuilder.DropForeignKey(
                name: "FK_UserAccessLogs_AspNetUser_AspNetUserId",
                table: "UserAccessLogs");

            migrationBuilder.DropForeignKey(
                name: "FK_UserLikes_AspNetUser_AspNetUserId",
                table: "UserLikes");

            migrationBuilder.DropTable(
                name: "AspNetUser");

            migrationBuilder.DropIndex(
                name: "IX_UserLikes_AspNetUserId",
                table: "UserLikes");

            migrationBuilder.DropIndex(
                name: "IX_UserAccessLogs_AspNetUserId",
                table: "UserAccessLogs");

            migrationBuilder.DropIndex(
                name: "IX_Reports_AspNetUserId",
                table: "Reports");

            migrationBuilder.DropIndex(
                name: "IX_Replies_AspNetUserId",
                table: "Replies");

            migrationBuilder.DropIndex(
                name: "IX_Ratings_AspNetUserId",
                table: "Ratings");

            migrationBuilder.DropIndex(
                name: "IX_Orders_AspNetUserId",
                table: "Orders");

            migrationBuilder.DropIndex(
                name: "IX_Notifications_AspNetUserId",
                table: "Notifications");

            migrationBuilder.DropIndex(
                name: "IX_Messages_AspNetUserId",
                table: "Messages");

            migrationBuilder.DropIndex(
                name: "IX_Messages_AspNetUserId1",
                table: "Messages");

            migrationBuilder.DropIndex(
                name: "IX_CustomArrangements_AspNetUserId",
                table: "CustomArrangements");

            migrationBuilder.DropIndex(
                name: "IX_ChatConversations_AspNetUserId",
                table: "ChatConversations");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "UserLikes");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "UserAccessLogs");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Reports");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Replies");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Ratings");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Notifications");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "Messages");

            migrationBuilder.DropColumn(
                name: "AspNetUserId1",
                table: "Messages");

            migrationBuilder.DropColumn(
                name: "AspNetUserId",
                table: "CustomArrangements");

            migrationBuilder.AlterColumn<string>(
                name: "AspNetUserId",
                table: "ChatConversations",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ChatConversations_AspNetUsers_UserId",
                table: "ChatConversations",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ChatConversations_AspNetUsers_UserId",
                table: "ChatConversations");

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "UserLikes",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "UserAccessLogs",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Reports",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Replies",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Ratings",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Orders",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Notifications",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "Messages",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId1",
                table: "Messages",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AspNetUserId",
                table: "CustomArrangements",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "AspNetUserId",
                table: "ChatConversations",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.CreateTable(
                name: "AspNetUser",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int", nullable: false),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    FullName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LockoutEnabled = table.Column<bool>(type: "bit", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    NormalizedEmail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    NormalizedUserName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    ProfileImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RoleId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SecurityStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Token = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "bit", nullable: false),
                    UserName = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUser", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserLikes_AspNetUserId",
                table: "UserLikes",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserAccessLogs_AspNetUserId",
                table: "UserAccessLogs",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Reports_AspNetUserId",
                table: "Reports",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Replies_AspNetUserId",
                table: "Replies",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Ratings_AspNetUserId",
                table: "Ratings",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_AspNetUserId",
                table: "Orders",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_AspNetUserId",
                table: "Notifications",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Messages_AspNetUserId",
                table: "Messages",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Messages_AspNetUserId1",
                table: "Messages",
                column: "AspNetUserId1");

            migrationBuilder.CreateIndex(
                name: "IX_CustomArrangements_AspNetUserId",
                table: "CustomArrangements",
                column: "AspNetUserId");

            migrationBuilder.CreateIndex(
                name: "IX_ChatConversations_AspNetUserId",
                table: "ChatConversations",
                column: "AspNetUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_ChatConversations_AspNetUser_AspNetUserId",
                table: "ChatConversations",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ChatConversations_AspNetUser_UserId",
                table: "ChatConversations",
                column: "UserId",
                principalTable: "AspNetUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomArrangements_AspNetUser_AspNetUserId",
                table: "CustomArrangements",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_AspNetUser_AspNetUserId",
                table: "Messages",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_AspNetUser_AspNetUserId1",
                table: "Messages",
                column: "AspNetUserId1",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Notifications_AspNetUser_AspNetUserId",
                table: "Notifications",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_AspNetUser_AspNetUserId",
                table: "Orders",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Ratings_AspNetUser_AspNetUserId",
                table: "Ratings",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Replies_AspNetUser_AspNetUserId",
                table: "Replies",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Reports_AspNetUser_AspNetUserId",
                table: "Reports",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_UserAccessLogs_AspNetUser_AspNetUserId",
                table: "UserAccessLogs",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_UserLikes_AspNetUser_AspNetUserId",
                table: "UserLikes",
                column: "AspNetUserId",
                principalTable: "AspNetUser",
                principalColumn: "Id");
        }
    }
}
