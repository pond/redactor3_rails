$(function () {
    // Pass authenticity_token
    var params = '[name="authenticity_token"]';
    // Set global settings
    $.Redactor.settings = {
        //plugins: ['source', 'fullscreen', 'textdirection', 'clips'],
        imageUpload: '/redactor3_rails/images',
        imageManagerJson: '/redactor3_rails/images',
        imageUploadFields: params,
        fileUpload: '/redactor3_rails/files',
        fileManagerJson: '/redactor3_rails/files',
        fileUploadFields: params
    };
    // Initialize Redactor
    $('.redactor').redactor();
});
