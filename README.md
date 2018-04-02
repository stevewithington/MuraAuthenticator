# MuraAuthenticator

This is a [Mura](http://www.getmura.com/) Module for implementing [Multi-Factor Authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication).

## Setup Instructions
* Drop this module into a valid `modules` directory. For example, `{MuraRoot}/modules/MuraAuthenticator`
* In the `/config/settings.ini.cfm` file, set `mfa=true` and reload Mura
* The next time a user attempts to log in, they will be prompted with instructions on what to do next.

## Important Notes
* Once enabled, Mura users *must* install an authentication app such as [Authy](https://authy.com/download/) (recommended), Google Authenticator ([iOS](https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8) or [Apple](https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8) or [Android](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en)), or Microsoft Authenticator ([Windows Phone](https://www.microsoft.com/en-us/store/p/authenticator-for-windows/9nblggh4n8mx), [Android](https://play.google.com/store/apps/details?id=com.azure.authenticator&hl=en), or [iOS](https://itunes.apple.com/us/app/microsoft-authenticator/id983156458?mt=8)).
* If a user loses their authentication device, and does not have access to any of their pre-generated backup codes, they will be required to contact the site administrator.

### Minimum Requirements
* [Mura](http://www.getmura.com/) v7.1+
* [Adobe ColdFusion](http://www.adobe.com/coldfusion) 2016+ or [Lucee](http://lucee.org/) 5.0+

## Future
* Notify user of remaining backup codes (after using one)
* Add ability to regenerate backup codes

## Additional Resources
* [GoogleAuth](https://github.com/wstrange/GoogleAuth) by Warren Strange and Enrico M. Crisostomo

## License
Copyright 2018 Stephen J. Withington, Jr. (and others -- see individual files for additional copyright holders).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.