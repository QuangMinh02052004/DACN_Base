using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bloomie.Migrations
{
    /// <inheritdoc />
    public partial class AddCustomArrangementFeature : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<decimal>(
                name: "BasePrice",
                table: "PresentationStyles",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "PresentationStyles",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "PresentationStyles",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AvailableColors",
                table: "FlowerTypes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "FlowerTypes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "FlowerTypes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "UnitPrice",
                table: "FlowerTypes",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.CreateTable(
                name: "CustomArrangements",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PresentationStyleId = table.Column<int>(type: "int", nullable: false),
                    BasePrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    FlowersCost = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TotalPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsSaved = table.Column<bool>(type: "bit", nullable: false),
                    IsOrdered = table.Column<bool>(type: "bit", nullable: false),
                    OrderId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PreviewImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CustomArrangements", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CustomArrangements_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_CustomArrangements_PresentationStyles_PresentationStyleId",
                        column: x => x.PresentationStyleId,
                        principalTable: "PresentationStyles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "CustomArrangementFlowers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CustomArrangementId = table.Column<int>(type: "int", nullable: false),
                    FlowerTypeId = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    Color = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UnitPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TotalPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CustomArrangementFlowers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CustomArrangementFlowers_CustomArrangements_CustomArrangementId",
                        column: x => x.CustomArrangementId,
                        principalTable: "CustomArrangements",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CustomArrangementFlowers_FlowerTypes_FlowerTypeId",
                        column: x => x.FlowerTypeId,
                        principalTable: "FlowerTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CustomArrangementFlowers_CustomArrangementId",
                table: "CustomArrangementFlowers",
                column: "CustomArrangementId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomArrangementFlowers_FlowerTypeId",
                table: "CustomArrangementFlowers",
                column: "FlowerTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomArrangements_PresentationStyleId",
                table: "CustomArrangements",
                column: "PresentationStyleId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomArrangements_UserId",
                table: "CustomArrangements",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CustomArrangementFlowers");

            migrationBuilder.DropTable(
                name: "CustomArrangements");

            migrationBuilder.DropColumn(
                name: "BasePrice",
                table: "PresentationStyles");

            migrationBuilder.DropColumn(
                name: "Description",
                table: "PresentationStyles");

            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "PresentationStyles");

            migrationBuilder.DropColumn(
                name: "AvailableColors",
                table: "FlowerTypes");

            migrationBuilder.DropColumn(
                name: "Description",
                table: "FlowerTypes");

            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "FlowerTypes");

            migrationBuilder.DropColumn(
                name: "UnitPrice",
                table: "FlowerTypes");
        }
    }
}
