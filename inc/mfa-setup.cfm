<cfscript>
    local.gAuth = new mura.googleAuth();
    local.credentials = local.gAuth.createCredentials();
    local.sharedSecret = local.credentials.getKey();
    local.verificationCode = local.credentials.getVerificationCode();
    local.scratchCodes = local.credentials.getScratchCodes();
    local.issuer = m.siteConfig('site') != 'Default' ? m.siteConfig('site') : 'blueriver';
    local.accountName = local.user.get('username');
    local.QRCode = local.gAuth.getOtpAuthURL(local.accountName, local.credentials, local.issuer);

    try {
        local.user
            .set('muraauthkey', local.sharedSecret)
            .set('muraauthverificationcode', local.verificationCode)
            .set('muraauthscratchcodes', ArrayToList(local.scratchCodes))
            .save();
    } catch(any e) {
        // for testing only - should handle differently in production
        WriteDump(e);
        abort;
    }
</cfscript> 

<cfoutput>
    <div class="muraauth-mfa-setup">
        <h1>Multi-Factor Authentication (MFA)</h1>
        <p>Your site requires <a href="https://en.wikipedia.org/wiki/Multi-factor_authentication" target="_blank">Multi-Factor Authentication (MFA)</a>. In order to continue, please complete the following steps:</p>
        <ol class="muraauth-ol">
            <li>
                Install an authentication app such as <a href="https://authy.com/download/" target="_blank">Authy</a> <em>(recommended)</em>, 
                Google Authenticator (<a href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8" target="_blank">iOS</a> or <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8" target="_blank">Apple</a> or <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&amp;hl=en" target="_blank">Android</a>), 
                or Microsoft Authenticator (<a href="https://www.microsoft.com/en-us/store/p/authenticator-for-windows/9nblggh4n8mx" target="_blank">Windows Phone</a>, <a href="https://play.google.com/store/apps/details?id=com.azure.authenticator&amp;hl=en" target="_blank">Android</a>, or <a href="https://itunes.apple.com/us/app/microsoft-authenticator/id983156458?mt=8" target="_blank">iOS</a>)
            </li>
            <li>In the app, add an account.</li>
            <li>
                Use the camera to scan the QR code below:
                <figure class="muraauth-qrcode-figure">
                    <img id="muraauth-qrcode" alt="qrcode" class="muraauth-qrcode-image" width="200" height="200" src="#local.QRCode#" />
                </figure>

                <div class="muraauth-qrcode-message">
                    If you are unable to scan the image, manually enter the following information in your app:
                    <ul>
                        <li>
                            <strong>Account:</strong> 
                            #local.accountName#
                        </li>
                        <li>
                            <strong>Key:</strong> 
                            #local.sharedSecret#
                        </li>
                    </ul>
                </div>
            </li>
            <li>If the app displays a six-digit code, it's been added correctly.</li>
            <li>
                <div id="muraauth-backup-codes-wrapper">
                    <p><strong>Backup codes for <em>#local.accountName#</em></strong></p>
                    <p>Store these backup codes somewhere safe - print them, write them down, or save a screenshot. If you ever lose access to your device, you can use these codes to verify your identity.</p>
                    <ul id="muraauth-backup-codes">
                        <cfloop array="#local.scratchCodes#" index="local.x">
                            <li class="muraauth-backup-code">#local.x#</li>
                        </cfloop>
                    </ul>
                    <div class="alert alert-warning">
                        You can only use each backup code once.<br>
                        <small>Generated on: #LSDateFormat(Now())#</small>
                    </div>
                </div>
                <div class="mura-focus-actions">
                    <button id="muraauth-print-backup-codes" class="btn btn-danger">
                        Print Backup Codes
                    </button>
                </div>
            </li>
            <li>Lastly, verify your code by entering it in the form below.</li>
        </ol>
    </div>
</cfoutput>