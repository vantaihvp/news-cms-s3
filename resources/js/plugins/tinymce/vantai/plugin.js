(function () {
    var vantai = (function () {
        'use strict';
        var global = tinymce.util.Tools.resolve('tinymce.PluginManager');
        var open = function (editor, pluginUrl) {
            return function () {
                editor.windowManager.open({
                    title: 'VanTai',
                    body: [{
                            label: 'Embed',
                            type: 'textbox',
                            name: 'embed',
                        },
                        {
                            label: 'container2',
                            type: 'textbox',
                            name: 'title2',
                        }
                    ],
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
        global.add('vantai', function (editor, pluginUrl) {
            editor.addButton('vantai', {
                icon: false,
                text: 'Insert HTML',
                onclick: Dialog.open(editor, pluginUrl)
            });
            Commands.register(editor, pluginUrl);
        });

        function Plugin() {}

        return Plugin;

    }());
})();
