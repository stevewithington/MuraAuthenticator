/**
 * [MuraAuthenticator](https://github.com/stevewithington/MuraAuthenticator)
 * By: [Steve Withington](https://github.com/stevewithington)
 */
if (!window.console) console = {
    log: function () {}
    , warn: function () {}
    , clear: function () {}
};

// Prevent i-frame
this.top.location !== this.location && (this.top.location = this.location);

// Global Vars
var debug = true
    , locationHash = window.location.hash
    , locationHref = window.location.href
    , logData = function (data, clear) {
        if (!debug) {
            return true;
        }
        var clear = clear !== 'undefined' && clear === true;
        if (clear) {
            console.clear();
        }
        console.warn(data);
    };

jQuery(document).ready(function ($) {

    if (typeof MuraAuthenticator === 'undefined') {
        var MuraAuthenticator = {
            init: function () {
                var txtauthcode = $('input#muraauth-authcode')
                    , imgqrcode = $('img#muraauth-qrcode');

                if (!imgqrcode.length && txtauthcode.length) {
                    txtauthcode.focus();
                }
            }

            , printElem: function (elem) {
                var printHtml = $(elem).html();
                var html = '<!DOCTYPE html><html><head><title>'
                    + document.title
                    + '</title></head><body>'
                    + '<h1>' + document.title + '</h1>'
                    + printHtml
                    + '</body></html>';

                var mywin = window.open('', 'PRINT', 'height=400,width=600');
                if ( mywin !== null ) {
                    try {
                        mywin.document.write(html);
                        mywin.document.close();

                        mywin.focus();
                        mywin.print();
                        mywin.close();
                    } catch(err) {
                        console.log(err);
                    };
                }

                return true;
            }

            , getUserByUserID: function (userid) {
                return new Promise(function (resolve, reject) {
                    Mura.getEntity('user')
                        .loadBy('userid', userid)
                        .then(function (result) {
                            resolve(result);
                        })
                        .catch(function (err) {
                            reject(err);
                        });
                });
            }

            , saveUser: function (user) {
                return new Promise(function (resolve, reject) {
                    user.save()
                        .then(function (result) {
                            resolve(result);
                        })
                        .catch(function (err) {
                            reject(err);
                        });
                });
            }

            , resetMuraAuthUser: function (userid) {
                return MuraAuthenticator.getUserByUserID(userid)
                    .then(function (user) {
                        user
                            .set('muraauthkey', '')
                            .set('muraauthverificationcode', '')
                            .set('muraauthscratchcodes', '')
                            .set('muraauthdeviceverified', '')
                            .set('muraauthdatelastverified', '');

                        return MuraAuthenticator.saveUser(user);
                    })
                    .then(function (result) {
                        $('#action-modal').remove();

                        alertDialog({
                            title: 'MFA Settings Reset'
                            , message: 'All Multi-Factor Authentication settings have been reset. The next time the user attempts to login, they will be required to complete the setup process again.'
                            , okAction: function () {
                                var btn = $('button#muraauth-reset-user')
                                    , parentEl = btn.parent()
                                    , msg = '<div class="help-block">This user\'s Multi-Factor Authentication settings have either been reset, or the user has not completed the verification steps yet.</div>';

                                btn.remove();
                                parentEl.append(msg);
                            }
                        });
                    })
                    .catch(function (err) {
                        $('#action-modal').remove();

                        alertDialog({
                            title: 'MFA Settings Reset Error'
                            , message: 'Something went wrong when attempting to reset the Multi-Factor Authentication settings.'
                        });
                    });
            }
        }
    }
    // @end typeof MuraAuthenticator

    // Standard jQuery stuff
        $('.muraauth-mfa-setup').parents('#mura-login').css('margin-top', '30em');

        $('#muraauth-print-backup-codes').on('click', function (e) {
            return MuraAuthenticator.printElem('#muraauth-backup-codes-wrapper');
        });

        $('#muraauth-reset-user').on('click', function (e) {
            e.preventDefault();
            var self = this
                , uid = $(self).data('userid');

            confirmDialog({
                title: 'Are you sure?'
                , message: 'If you proceed, you will clear all MuraAuthenticator info.'
                , yesAction: function () {
                    $('body').append('<div id="action-modal" class="modal-backdrop fade in"></div>');
                    $('#action-modal').spin(spinnerArgs);
                    MuraAuthenticator.resetMuraAuthUser(uid);
                }
            });

            return false;
        });
    // @end Standard jQuery Stuff

    MuraAuthenticator.init();
});