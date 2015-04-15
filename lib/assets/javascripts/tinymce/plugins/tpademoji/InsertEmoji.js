function init() {
    if (tinymce.isIE) {
      tinyMCE.get('content').focus();
      tinyMCE.activeEditor.windowManager.bookmark = tinyMCE.activeEditor.selection.getBookmark();
    }
	tinyMCEPopup.resizeToInnerSize();
}

function emojiinsert(line, icon) {

	var icontag;
	icontag = '<img src="'+tpademojidomain+'icons/'+line+'/'+icon+'" width="16" height="16" style="margin-left:3px; margin-right:3px; vertical-align:middle;">';

    if (parent.tinymce.isIE) {
      parent.tinyMCE.activeEditor.focus();
      parent.tinyMCE.activeEditor.selection.moveToBookmark(parent.tinymce.EditorManager.activeEditor.windowManager.bookmark);
    }

	window.tinyMCE.execInstanceCommand('content', 'mceInsertContent', false, icontag);
	tinyMCEPopup.editor.execCommand('mceRepaint');
	tinyMCEPopup.close();
	return;
}
