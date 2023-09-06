// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
import "jquery_ujs"
import "bootstrap"
import "popper"
import * as jq from 'jquery';

// import Uppy from '@uppy/core'
// import ActiveStorageUpload from '@excid3/uppy-activestorage-upload'

$(document).on('turbo:load', function(){
  $("body").on("click", "a.list-group-item", function(){
    toggleAnchorActive(checkClassState($(this), "active"), $(this), $(this).closest(".sidebar").find("a.active"), $(this).attr("id").toString(), $(this).attr("href"), "tags")
  });
});

function toggleAnchorActive(state, a, sibling, id, href, key){
  var href = href.slice(0, href.indexOf(key))+key+"="+(state==true ? [] : id);
  $(a).attr("href", href);
  toggleClass(a, "active text-danger");
  if (state==false) $(sibling).removeClass("active text-danger");
}
function checkClassState(target, klass) {
  return $(target).hasClass(klass) ? true : false
}
function toggleClass(target, klass) {
  $(target).hasClass(klass) ? $(target).removeClass(klass) : $(target).addClass(klass);
}

// function update_href(a, id, href) {
//   var href = href.replace(id, []);
//   $(a).attr("href", href);
// }

// function toggleActive(a, sibling) {
//   var state = toggleIntraClass(a, "active");
//   if (state==true) {
//     toggleClass(a, "text-danger");
//     $(sibling).removeClass("active text-danger");
//   } else{
//     $(a).removeClass("text-danger");
//   }
//   return state
// }

//TOGGLE CLASS (BINARY)
// function toggleIntraClass(target, klass) {
//   toggleClass(target, klass); //$(target).hasClass(klass) ? $(target).removeClass(klass) : $(target).addClass(klass);
//   return $(target).hasClass(klass) ? true : false
// }

// function setHiddenInputs(hidden_field, id) {
//   var search_id = $(hidden_field).val();
//   if (search_id == id) {
//     $(hidden_field).val("");
//   } else if (search_id == undefined || search_id != id) {
//     $(hidden_field).val(id);
//   }
//   return hidden_field
// }
// function toggleIndexResults(a) {
//   var [type, name, count] = [$(a).data("type"), $(a).data("name"), $(a).data("count")];
// }

// const singleFileUpload = (fileInput) => {
//   const imagePreview = document.getElementById(fileInput.dataset.previewElement)
//   const formGroup    = fileInput.parentNode
//
//   formGroup.removeChild(fileInput)
//
//   const uppy = fileUpload(fileInput)
//
//   uppy
//     .use(Uppy.FileInput, {
//       target: formGroup,
//       locale: { strings: { chooseFiles: 'Choose file' } },
//     })
//     .use(Uppy.Informer, {
//       target: formGroup,
//     })
//     .use(Uppy.ProgressBar, {
//       target: imagePreview.parentNode,
//     })
//     .use(Uppy.ThumbnailGenerator, {
//       thumbnailWidth: 600,
//     })
//
//   uppy.on('upload-success', (file, response) => {
//     // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
//     const hiddenInput = document.getElementById(fileInput.dataset.uploadResultElement)
//     hiddenInput.value = uploadedFileData(file, response, fileInput)
//   })
//
//   uppy.on('thumbnail:generated', (file, preview) => {
//     imagePreview.src = preview
//   })
// }
//
// const multipleFileUpload = (fileInput) => {
//   var formGroup = fileInput.parentNode
//
//   var uppy = fileUpload(fileInput)
//
//   uppy
//     .use(Uppy.Dashboard, {
//       target: formGroup,
//       inline: true,
//       height: 300,
//       replaceTargetContent: true,
//     })
//
//   uppy.on('upload-success', (file, response) => {
//     const hiddenField = document.createElement('input')
//
//     hiddenField.type = 'hidden'
//     hiddenField.name = 'album[photos_attributes]['+ Math.random().toString(36).substr(2, 9) + '][image]'
//     hiddenField.value = uploadedFileData(file, response, fileInput)
//
//     document.querySelector('form').appendChild(hiddenField)
//   })
// }
//
// const fileUpload = (fileInput) => {
//   const uppy = new Uppy.Core({
//     id: fileInput.id,
//     autoProceed: true,
//     restrictions: {
//       allowedFileTypes: fileInput.accept.split(','),
//     },
//   })
//
//   if (fileInput.dataset.uploadServer == 's3') {
//     uppy.use(Uppy.AwsS3, {
//       companionUrl: '/', // will call Shrine's presign endpoint mounted on `/s3/params`
//     })
//   } else {
//     uppy.use(Uppy.XHRUpload, {
//       endpoint: '/upload', // Shrine's upload endpoint
//       headers: { 'X-CSRF-Token': fileInput.dataset.uploadCsrfToken }
//     })
//   }
//
//   return uppy
// }
//
// const uploadedFileData = (file, response, fileInput) => {
//   if (fileInput.dataset.uploadServer == 's3') {
//     // construct uploaded file data in the format that Shrine expects
//     return JSON.stringify({
//       id: file.meta['key'].match(/^cache\/(.+)/)[1], // object key without prefix
//       storage: 'cache',
//       metadata: {
//         size:      file.size,
//         filename:  file.name,
//         mime_type: file.type,
//       }
//     })
//   } else {
//     return JSON.stringify(response.body)
//   }
// }
//
// document.querySelectorAll('input[type=file]').forEach((fileInput) => {
//   if (fileInput.multiple) {
//     multipleFileUpload(fileInput)
//   } else {
//     singleFileUpload(fileInput)
//   }
// })

// function fileUpload(fileInput) {
//   var formGroup = fileInput.parentNode
//   var hiddenInput = document.querySelector('.upload-data')
//   var imagePreview = document.querySelector('.image-preview img')
//
//   formGroup.removeChild(fileInput)
//
//   var uppy = Uppy.Core({
//       autoProceed: true,
//       restrictions: {
//         allowedFileTypes: fileInput.accept.split(','),
//       }
//     })
//     .use(Uppy.FileInput, {
//       target: formGroup,
//       locale: { strings: { chooseFiles: 'Choose file' } },
//     })
//     .use(Uppy.Informer, {
//       target: formGroup,
//     })
//     .use(Uppy.ProgressBar, {
//       target: imagePreview.parentNode,
//     })
//     .use(Uppy.ThumbnailGenerator, {
//       thumbnailWidth: 600,
//     })
//     .use(Uppy.XHRUpload, {
//       endpoint: '/upload',
//     })
//
//   uppy.on('upload-success', function (file, response) {
//     imagePreview.src = response.uploadURL
//
//     var uploadedFileData = JSON.stringify(response.body['data'])
//
//     hiddenInput.value = uploadedFileData
//
//     var copper = new Cropper(imagePreview, {
//       aspectRatio: 1,
//       viewMode: 1,
//       guides: false,
//       autoCropArea: 1.0,
//       background: false,
//       crop: function (event) {
//         data = JSON.parse(hiddenInput.value)
//         data['metadata']['crop'] = event.detail
//         hiddenInput.value = JSON.stringify(data)
//       }
//     })
//   })
// }
//
// document.querySelectorAll('input[type="file"]').forEach(function (fileInput) {
//   fileUpload(fileInput)
// })
