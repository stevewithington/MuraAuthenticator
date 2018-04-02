<cfset local.isadminlogin = IsBoolean(arguments.m.event('isadminlogin')) ? arguments.m.event('isadminlogin') : false />
<cfoutput>
    <h1>Security Verification</h1>

    <form class="muraauth" novalidate="novalidate" id="muraauth-verification-form" name="muraauth-verification-form" method="post" action="index.cfm" onsubmit="return submitForm(this);">
        <div class="form-group">
            <input type="text" class="form-control" id="muraauth-authcode" name="authcode" placeholder="Enter 6-digit verification code" autocomplete="off" value="" />
        </div>

        <div class="mura-focus-actions">
            <button id="muraauth-verify-submit" class="btn btn-primary" type="submit">Submit</button>
        </div>

        <cfif local.isadminlogin>
            <input type="hidden" name="muraAction" value="cLogin.login" />
        <cfelse>
            <input type="hidden" name="doaction" value="login" />
        </cfif>
        <input type="hidden" name="status" value="challenge" />
        <input type="hidden" name="attemptChallenge" value="true" />
        <input type="hidden" name="isadminlogin" value="#local.isadminlogin#" />

        #m.renderCSRFTokens(format='form',context='login')#

        <!--- Only show message if user has verified device and failedchallenge --->
        <cfif local.user.get('muraauthdeviceverified') eq true and arguments.m.event('failedchallenge') eq true>
            <hr class="muraauth-hr">
            <div class="form-group">
                <small>If you have lost your authentication device, and you do not have access to your backup codes, you will need to contact your site Administrator.</small>
            </div>
        </cfif>
    </form>
</cfoutput>