// Custom Flower Arrangement Designer
let currentArrangementId = null;
let selectedPresentationStyle = null;
let selectedFlowers = [];
let basePrice = 0;
let flowersCost = 0;
let totalPrice = 0;

$(document).ready(function () {
    initializeDesigner();
});

function initializeDesigner() {
    // Presentation Style Selection
    $('.presentation-style-item').click(function () {
        $('.presentation-style-item').removeClass('border-primary bg-light');
        $(this).addClass('border-primary bg-light');

        selectedPresentationStyle = {
            id: $(this).data('style-id'),
            name: $(this).find('h6').text(),
            basePrice: parseFloat($(this).data('base-price'))
        };

        basePrice = selectedPresentationStyle.basePrice;

        $('#selected-presentation').show();
        $('#selected-presentation-name').text(selectedPresentationStyle.name);
        $('#selected-presentation-price').text(formatCurrency(basePrice));

        updatePriceDisplay();

        // TẠO ARRANGEMENT NGAY KHI CHỌN PRESENTATION STYLE
        if (!currentArrangementId) {
            createArrangement(function(arrangementId) {
                currentArrangementId = arrangementId;
                console.log('Created arrangement:', currentArrangementId);
            });
        }
    });

    // Flower Search
    $('#flower-search').on('keyup', function () {
        var searchText = $(this).val().toLowerCase();
        $('.flower-item').each(function () {
            var flowerName = $(this).find('h6').text().toLowerCase();
            if (flowerName.includes(searchText)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    // Toggle Inline Flower Form
    $(document).on('click', '.toggle-flower-form', function (e) {
        e.preventDefault();

        var flowerId = $(this).data('flower-id');
        var formId = '#flower-form-' + flowerId;

        // Hide all other forms
        $('.flower-form').not(formId).slideUp();

        // Toggle this form
        $(formId).slideToggle(function() {
            // Initialize subtotal when form opens
            if ($(this).is(':visible')) {
                updateInlineSubtotal($(this));
            }
        });
    });

    // Increase Quantity
    $(document).on('click', '.increase-qty', function () {
        var input = $(this).closest('.input-group').find('.flower-quantity');
        var currentVal = parseInt(input.val()) || 0;
        input.val(currentVal + 1);
        updateInlineSubtotal($(this).closest('.flower-form'));
    });

    // Decrease Quantity
    $(document).on('click', '.decrease-qty', function () {
        var input = $(this).closest('.input-group').find('.flower-quantity');
        var currentVal = parseInt(input.val()) || 0;
        if (currentVal > 1) {
            input.val(currentVal - 1);
            updateInlineSubtotal($(this).closest('.flower-form'));
        }
    });

    // Quantity Input Change - Allow direct typing
    $(document).on('input change', '.flower-quantity', function () {
        var val = parseInt($(this).val()) || 1;

        // Ensure minimum value
        if (val < 1) {
            $(this).val(1);
            val = 1;
        }

        // Ensure maximum value (optional, e.g., 999)
        if (val > 999) {
            $(this).val(999);
            val = 999;
        }

        updateInlineSubtotal($(this).closest('.flower-form'));
    });

    // Color Selection Change
    $(document).on('change', '.flower-color', function () {
        updateInlineSubtotal($(this).closest('.flower-form'));
    });

    // Confirm Add Flower from Inline Form
    $(document).on('click', '.confirm-add-flower', function () {
        var form = $(this).closest('.flower-form');
        addFlowerFromInlineForm(form);
    });

    // Cancel Flower Form
    $(document).on('click', '.cancel-flower-form', function () {
        var form = $(this).closest('.flower-form');
        resetFlowerForm(form);
        form.slideUp();
    });

    // Save Arrangement
    $('#save-arrangement-btn').click(function () {
        saveArrangement();
    });

    // Add to Cart
    $('#add-to-cart-btn').click(function () {
        addToCart();
    });
}

function updateInlineSubtotal(formElement) {
    var quantity = parseInt(formElement.find('.flower-quantity').val()) || 0;
    var unitPrice = parseFloat(formElement.data('unit-price')) || 0;
    var subtotal = quantity * unitPrice;
    formElement.find('.flower-subtotal').val(formatCurrency(subtotal));
}

function resetFlowerForm(formElement) {
    formElement.find('.flower-quantity').val(3);
    formElement.find('.flower-color').val('');
    formElement.find('.flower-notes').val('');
    formElement.find('.flower-subtotal').val('0 đ');
}

function addFlowerFromInlineForm(formElement) {
    var flowerId = parseInt(formElement.data('flower-id'));
    var flowerName = formElement.data('flower-name');
    var quantity = parseInt(formElement.find('.flower-quantity').val());
    var color = formElement.find('.flower-color').val();
    var unitPrice = parseFloat(formElement.data('unit-price'));
    var notes = formElement.find('.flower-notes').val() || '';

    if (!color) {
        alert('Vui lòng chọn màu sắc');
        return;
    }

    if (!selectedPresentationStyle) {
        alert('Vui lòng chọn kiểu trình bày trước');
        return;
    }

    // Create arrangement if not exists
    if (!currentArrangementId) {
        createArrangement(function (arrangementId) {
            currentArrangementId = arrangementId;
            addFlowerRequest(flowerId, flowerName, quantity, color, unitPrice, notes, formElement);
        });
    } else {
        addFlowerRequest(flowerId, flowerName, quantity, color, unitPrice, notes, formElement);
    }
}

function createArrangement(callback) {
    var arrangementName = $('#arrangement-name').val() || 'Bó hoa của tôi';
    var description = $('#arrangement-description').val();

    $.ajax({
        url: '/CustomArrangement/CreateArrangement',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            name: arrangementName,
            description: description,
            presentationStyleId: selectedPresentationStyle.id
        }),
        success: function (response) {
            if (response.success) {
                callback(response.arrangementId);
            } else {
                alert(response.message || 'Không thể tạo bó hoa');
            }
        },
        error: function () {
            alert('Có lỗi xảy ra khi tạo bó hoa');
        }
    });
}

function addFlowerRequest(flowerId, flowerName, quantity, color, unitPrice, notes, formElement) {
    $.ajax({
        url: '/CustomArrangement/AddFlower',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            arrangementId: currentArrangementId,
            flowerTypeId: flowerId,
            quantity: quantity,
            color: color,
            notes: notes
        }),
        success: function (response) {
            if (response.success) {
                var flower = {
                    id: response.flowerId,
                    flowerId: flowerId,
                    name: flowerName,
                    quantity: quantity,
                    color: color,
                    unitPrice: unitPrice,
                    totalPrice: quantity * unitPrice,
                    notes: notes
                };

                selectedFlowers.push(flower);
                renderSelectedFlowers();
                updatePriceDisplay();
                checkCanSave();

                // Close inline form and reset
                if (formElement) {
                    resetFlowerForm(formElement);
                    formElement.slideUp();
                }

                totalPrice = response.totalPrice;
                updatePriceDisplay();
            } else {
                alert(response.message || 'Không thể thêm hoa');
            }
        },
        error: function () {
            alert('Có lỗi xảy ra khi thêm hoa');
        }
    });
}

function renderSelectedFlowers() {
    var container = $('#selected-flowers');
    container.empty();

    if (selectedFlowers.length === 0) {
        container.html('<p class="text-muted text-center">Chưa có hoa nào được chọn</p>');
        return;
    }

    selectedFlowers.forEach(function (flower) {
        var flowerHtml = `
            <div class="card mb-2" data-flower-id="${flower.id}">
                <div class="card-body p-2">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="mb-1">${flower.name}</h6>
                            <p class="mb-0 small">
                                <span class="badge bg-secondary">${flower.color}</span>
                                ${flower.quantity} bông
                            </p>
                            <p class="mb-0 text-success"><strong>${formatCurrency(flower.totalPrice)}</strong></p>
                        </div>
                        <button class="btn btn-sm btn-outline-danger remove-flower" data-id="${flower.id}">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>
        `;
        container.append(flowerHtml);
    });

    // Remove flower event
    $('.remove-flower').click(function () {
        var flowerId = $(this).data('id');
        removeFlower(flowerId);
    });
}

function removeFlower(flowerId) {
    if (!confirm('Bạn có chắc muốn xóa loại hoa này?')) {
        return;
    }

    $.ajax({
        url: '/CustomArrangement/RemoveFlower',
        method: 'POST',
        data: { flowerId: flowerId },
        success: function (response) {
            if (response.success) {
                selectedFlowers = selectedFlowers.filter(f => f.id !== flowerId);
                renderSelectedFlowers();
                calculateTotalPrice();
            } else {
                alert(response.message || 'Không thể xóa hoa');
            }
        },
        error: function () {
            alert('Có lỗi xảy ra khi xóa hoa');
        }
    });
}

function calculateTotalPrice() {
    if (!currentArrangementId) {
        flowersCost = selectedFlowers.reduce((sum, f) => sum + f.totalPrice, 0);
        totalPrice = basePrice + flowersCost;
        updatePriceDisplay();
        return;
    }

    $.ajax({
        url: '/CustomArrangement/CalculatePrice',
        method: 'GET',
        data: { arrangementId: currentArrangementId },
        success: function (response) {
            if (response.success) {
                totalPrice = response.totalPrice;
                updatePriceDisplay();
            }
        }
    });
}

function updatePriceDisplay() {
    flowersCost = selectedFlowers.reduce((sum, f) => sum + f.totalPrice, 0);
    totalPrice = basePrice + flowersCost;

    $('#display-base-price').text(formatCurrency(basePrice));
    $('#display-flowers-cost').text(formatCurrency(flowersCost));
    $('#display-total-price').text(formatCurrency(totalPrice));
}

function saveArrangement() {
    if (!currentArrangementId) {
        alert('Vui lòng thêm ít nhất một loại hoa');
        return;
    }

    $.ajax({
        url: '/CustomArrangement/SaveArrangement',
        method: 'POST',
        data: { arrangementId: currentArrangementId },
        success: function (response) {
            if (response.success) {
                alert(response.message || 'Đã lưu bó hoa của bạn');
                window.location.href = '/CustomArrangement/SavedArrangements';
            } else {
                alert(response.message || 'Không thể lưu bó hoa');
            }
        },
        error: function () {
            alert('Có lỗi xảy ra khi lưu bó hoa');
        }
    });
}

function addToCart() {
    if (!currentArrangementId) {
        alert('Vui lòng thêm ít nhất một loại hoa');
        return;
    }

    $.ajax({
        url: '/CustomArrangement/AddToCart',
        method: 'POST',
        data: { arrangementId: currentArrangementId },
        success: function (response) {
            if (response.success) {
                alert(response.message || 'Đã thêm vào giỏ hàng');
                if (response.redirectUrl) {
                    window.location.href = response.redirectUrl;
                }
            } else {
                alert(response.message || 'Không thể thêm vào giỏ hàng');
            }
        },
        error: function () {
            alert('Có lỗi xảy ra khi thêm vào giỏ hàng');
        }
    });
}

function checkCanSave() {
    var canSave = selectedPresentationStyle && selectedFlowers.length > 0;
    $('#save-arrangement-btn').prop('disabled', !canSave);
    $('#add-to-cart-btn').prop('disabled', !canSave);
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}
