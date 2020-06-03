import {
    VueEditor,
    Quill
} from "vue2-editor";
const BlockEmbed = Quill.import("blots/block/embed");
class IframeBlot extends BlockEmbed {
    static create(value) {
        let node = super.create(value);
        node.setAttribute("class", "ql-align-center");
        node.innerHTML = value;
        return node;
    }
}
IframeBlot.blotName = "iframe";
IframeBlot.tagName = "html";
Quill.register(IframeBlot);
class PadingBlot extends BlockEmbed {
    static create(value) {
        let node = super.create(value);
        node.setAttribute("class", "ql-align-center");
        node.innerHTML = value;
        return node;
    }
}
PadingBlot.blotName = "padding";
Quill.register(PadingBlot);
