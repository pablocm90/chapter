var simplemde = new SimpleMDE({
  autofocus: true,
  element: document.getElementById("new-content"),
  autosave: {
    enabled: true,
    uniqueId: "MyUniqueID",
    delay: 1000,
  },
  toolbar: ["bold", "italic", "strikethrough", "|", "heading-2", "heading-3", "|", "quote", "clean-block", "horizontal-rule", "|", "preview", "guide"],
});
