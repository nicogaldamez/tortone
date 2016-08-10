$('#js-modal').html("<%= j render 'prepare_to_publish', locals: {presenter: @presenter} %>");
$('#js-modal').modal('show');
