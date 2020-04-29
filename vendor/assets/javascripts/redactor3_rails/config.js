$(document).on('ready page:load', function() {

    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;

    if (csrf_param !== undefined && csrf_token !== undefined)
    {
        params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }

    // Set global settings
    $R.options = {
        //plugins: ['source', 'fullscreen', 'textdirection', 'clips'],
        imageUpload:      '/redactor3_rails/images?' + params,
        imageManagerJson: '/redactor3_rails/images',
        fileUpload:       '/redactor3_rails/files?' + params,
        fileManagerJson:  '/redactor3_rails/files'
    };
    // Initialize Redactor
    $('.redactor').redactor();
});
