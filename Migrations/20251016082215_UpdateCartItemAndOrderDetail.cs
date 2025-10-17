using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bloomie.Migrations
{
    /// <inheritdoc />
    public partial class UpdateCartItemAndOrderDetail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CustomArrangementId",
                table: "OrderDetails",
                type: "int",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CustomArrangementId",
                table: "OrderDetails");
        }
    }
}
