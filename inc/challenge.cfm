<cfset local.user = m.getBean('user').loadBy(userid=session.mfa.userid) />
<cfset local.isBlocked = StructKeyExists(session, "blockLoginUntil") and IsDate(session.blockLoginUntil) and DateCompare(session.blockLoginUntil, Now()) eq 1 />
<cfoutput>
    <script>
        jQuery(document).ready(function($) {
            Mura.loader()
                .loadcss('#arguments.m.globalConfig('context')#/modules/MuraAuthenticator/assets/muraauthenticator.css')
                .loadjs('#arguments.m.globalConfig('context')#/modules/MuraAuthenticator/assets/muraauthenticator.js');
        });
    </script>

    <div class="muraauth-challenge-wrapper">

        <cfif local.isBlocked>
            <div class="alert alert-error">
                <span>#arguments.m.rbKey('login.blocked')#</span>
            </div>
        <cfelse>

            <!--- Only show if the user hasn't set up MFA yet --->
            <!--- REMOVE ability to generate newGAuth for production (used for testing only) --->
            <cfif m.event('newMuraAuth') eq true or not Len(local.user.get('muraauthdeviceverified')) or local.user.get('muraauthdeviceverified') eq false>
                <cftry>
                    <cfinclude template="mfa-setup.cfm" />
                    <cfcatch>
                        <cfdump var="#cfcatch#" />
                    </cfcatch>
                </cftry>
            </cfif>

            <!--- Always display --->
            <cftry>
                <cfinclude template="verification-form.cfm" />
                <cfcatch>
                    <cfdump var="#cfcatch#" />
                </cfcatch>
            </cftry>

        </cfif>

    </div>
</cfoutput>