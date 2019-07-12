$(document).ready(() => {
  if($('.settings-cont').length != 0) {
    let sel = {
      avtLabel: '.settings-avatar-img__label',
      bgLabel: '.settings-profile-bg-img__label',
      bgFileField: '.settings-profile-bg-img__file-picker',
      avtFileField: '.settings-avatar-img__file-picker',
      avtUploadBtn: '.settings-avatar-img__upload-btn',
      bgUploadBtn: '.settings-profile-bg-img__upload-btn',
      avtImg: '.settings-avatar-img__img',
      bgImg: '.settings-profile-bg-img__img',
    };

    let changeAvatarImg = (base64) => {
      $(sel.avtImg).attr('src', base64);
    }

    let changeBgImg = (base64) => {
      $(sel.bgImg).attr('src', base64);
    }

    let evtListeners = {
      avtOnImgChange: () => {
        $(sel.avtFileField).change( (evt) => {
          let getImg = () => {
            let file = evt.target.files[0];
            return file;
          };
          
          let file = getImg();

          let reader = new FileReader();
          reader.onload = (evt) => {
            changeAvatarImg(evt.target.result);
          };

          reader.readAsDataURL(file);

          $(sel.avtUploadBtn).css('display', 'block');
        } );
      },
      bgImgChange: () => {
        $(sel.bgFileField).change( (evt) => {
          let file = evt.target.files[0];

          let reader = new FileReader();
          reader.onload = (evt) => {
            changeBgImg(evt.target.result);
          };

          reader.readAsDataURL(file);

          $(sel.bgUploadBtn).css('display', 'block');
        } );
      },
      avtImgUpload: () => {
        $(sel.avtUploadBtn).click( (evt) => {
        } );
      }
    };

    let init = () => {
      evtListeners.avtOnImgChange();
      evtListeners.bgImgChange();
      evtListeners.avtImgUpload();
    };

    init();
  }
});
