using System;
using System.Collections.Generic;

namespace Bloomie.TempModels;

public partial class FlowerType
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int Quantity { get; set; }

    public bool IsActive { get; set; }

    public decimal UnitPrice { get; set; }

    public string? ImageUrl { get; set; }

    public string? AvailableColors { get; set; }

    public string? Description { get; set; }
}
