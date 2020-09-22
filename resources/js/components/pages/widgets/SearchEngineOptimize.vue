<template>
  <div class="card shadow-none card-seo">
    <div class="card-header">
      <div class="float-left">
        <h4 class="card-title">Search Engine Optimize</h4>
      </div>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse">
          <i class="fas fa-minus"></i>
        </button>
      </div>
    </div>
    <div class="card-body">
      <div class="wrap">
        <div class="content-sidebar-wrap">
          <div id="input" class="form-container">
            <div id="inputForm" class="inputForm">
              <label for="focusKeyword">Focus keyword</label>
              <input
                type="text"
                id="focusKeyword"
                name="focusKeyword"
                placeholder="Choose a focus keyword"
              />
              <label for="synonyms">Synonyms</label>
              <input type="text" id="synonyms" name="synonyms" placeholder="Choose synonyms" />
              <button type="button" id="refresh-analysis">Refresh!</button>
            </div>
            <form id="snippetForm" class="snippetForm">
              <div id="snippet" class="output"></div>
            </form>
          </div>
          <div id="output-container" class="output-container">
            <h2>SEO assessments</h2>
            <div id="output" class="output"></div>
            <h2>Content assessments</h2>
            <div id="contentOutput" class="output"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { forEach } from "lodash-es";
import { escape } from "lodash-es";
import SnippetPreview from "yoastseo/src/snippetPreview";
import PreviouslyUsedKeywords from "yoastseo/src/bundledPlugins/previouslyUsedKeywords.js";
import App from "yoastseo/src/app";
export default {
  name: "SearchEngineOptimize",
  props: {
    value: Object,
    myId: Number,
    myTitle: String,
    mySlug: String,
    myContent: String,
    myDescription: String,
    myKeyword: String,
    mySynonyms: String,
  },
  data() {
    return {
      title: "",
      slug: "",
      content: "",
      description: "",
      synonyms: "",
      focusKeyword: "",
    };
  },
  methods: {
    bindEventsInput() {
      var elems = [
        "focusKeyword",
        "synonyms",
        "snippet-editor-title",
        "snippet-editor-slug",
        "snippet-editor-meta-description",
      ];
      for (var i = 0; i < elems.length; i++) {
        document.getElementById(elems[i]).addEventListener("input", (event) => {
          this.$emit("input", {
            title: document.getElementById("snippet-editor-title").value,
            slug: document.getElementById("snippet-editor-slug").value,
            description: document.getElementById(
              "snippet-editor-meta-description"
            ).value,
            synonyms: document.getElementById("synonyms").value,
            keyword: document.getElementById("focusKeyword").value,
          });
        });
      }
    },
    initSeo(
      myTitle = "",
      mySlug = "",
      myContent = "",
      myDescription = "",
      myKeyword = "",
      mySynonyms = ""
    ) {
      if (myKeyword) {
        document.getElementById("focusKeyword").value = myKeyword;
      }
      if (mySynonyms) {
        document.getElementById("synonyms").value = mySynonyms;
      }
      var bindEvents = function (app) {
        var elems = ["focusKeyword", "synonyms"];
        for (var i = 0; i < elems.length; i++) {
          document
            .getElementById(elems[i])
            .addEventListener("input", app.refresh.bind(app));
        }
      };
      var snippetPreview = new SnippetPreview({
        targetElement: document.getElementById("snippet"),
      });
      snippetPreview.opts.data.title = myTitle;
      snippetPreview.opts.data.urlPath = mySlug;
      snippetPreview.opts.data.metaDesc = myDescription;
      var app = new App({
        snippetPreview: snippetPreview,
        targets: {
          output: "output",
          contentOutput: "contentOutput",
        },
        callbacks: {
          getData: function () {
            return {
              keyword: document.getElementById("focusKeyword").value,
              text: myContent,
              synonyms: document.getElementById("synonyms").value,
            };
          },
        },
        marker: function (paper, marks) {
          var text = paper.getText();
          forEach(marks, function (mark) {
            text = mark.applyWithReplace(text);
          });
          document.getElementsByClassName("marked-text")[0].innerHTML = text;
          document.getElementsByClassName(
            "marked-text-raw"
          )[0].innerHTML = escape(text);
        },
      });
      bindEvents(app);
      app.refresh();
      var refreshAnalysis = document.getElementById("refresh-analysis");
      refreshAnalysis.addEventListener("click", function () {
        app.runAnalyzer();
      });
    },
  },
  watch: {
    myContent: function (newVal, oldVal) {
      this.initSeo(
        this.myTitle,
        this.mySlug,
        this.myContent,
        this.myDescription,
        this.myKeyword,
        this.mySynonyms
      );
    },
    myTitle: function (newVal, oldVal) {
      this.initSeo(
        this.myTitle,
        this.mySlug,
        this.myContent,
        this.myDescription,
        this.myKeyword,
        this.mySynonyms
      );
    },
    mySlug: function (newVal, oldVal) {
      this.initSeo(
        this.myTitle,
        this.mySlug,
        this.myContent,
        this.myDescription,
        this.myKeyword,
        this.mySynonyms
      );
    },
    myDescription: function (newVal, oldVal) {
      this.initSeo(
        this.myTitle,
        this.mySlug,
        this.myContent,
        this.myDescription,
        this.myKeyword,
        this.mySynonyms
      );
    },
  },
  mounted: function () {
    this.initSeo(
      this.myTitle,
      this.mySlug,
      this.myContent,
      this.myDescription,
      this.myKeyword,
      this.mySynonyms
    );
    this.bindEventsInput();
  },
};
</script>

<style lang="scss">
.content-sidebar-wrap {
  padding: 0px;
}
</style>
