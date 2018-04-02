<cfset arguments.m.event('tabLabel', 'MuraAuthenticator') />
<cfset local.userBean = arguments.m.event().get('userbean') />
<cfoutput>
    <div class="fieldset">
        <cfif IsDate(local.userBean.get('muraauthdatelastverified'))>
            <div class="form-actions">
                <button id="muraauth-reset-user" class="btn mura-primary" data-userid="#local.userBean.get('userid')#">
                    <i class="mi-refresh"></i> Reset Multi-Factor Authentication Settings
                </button>
            </div>
        <cfelse>
            <div class="help-block">
                This user's Multi-Factor Authentication settings have either been reset, or the user has not completed the verification steps yet.
            </div>
        </cfif>
    </div>
</cfoutput>