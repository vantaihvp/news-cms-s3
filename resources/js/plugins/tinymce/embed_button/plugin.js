(function () {
    var embed_button = (function () {
        'use strict';
        var global = tinymce.util.Tools.resolve('tinymce.PluginManager');
        var open = function (editor, pluginUrl) {
            return function () {
                editor.windowManager.open({
                    title: 'Embed',
                    body: [{
                        type: 'textbox',
                        multiline: true,
                        name: 'embed',
                        minWidth: 350,
                        minHeight: 150
                    }, ],
                    onSubmit: function (api) {
                        console.log(api);
                        var data = api.data;
                        // // Insert content when the window form is submitted
                        editor.insertContent(data.embed);
                        // api.close();
                    }
                });
            };
        };
        var Dialog = {
            open: open
        };
        var register = function (editor, pluginUrl) {
            editor.addCommand('mceHelp', Dialog.open(editor, pluginUrl));
        };
        var Commands = {
            register: register
        };
        global.add('embed_button', function (editor, pluginUrl) {
            editor.addButton('embed_button', {
                // icon: false,
                icon: 'code',
                text: 'Embed',
                onclick: Dialog.open(editor, pluginUrl)
            });
            Commands.register(editor, pluginUrl);
        });

        function Plugin() {}

        return Plugin;

    }());
})();
