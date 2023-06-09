# Appcircle _App Center Android Distribute_ component

Distribute APK, AAB, and mapping files to App Center.

## Required Inputs

- `AC_APPCENTER_TOKEN`: API Token. Appcenter API Token.
- `AC_APPCENTER_APK_PATH`: APK or AAB Path. The full path of the build. Both APK($AC_APK_PATH, $AC_SIGNED_APK_PATH) and AAB($AC_AAB_PATH, $AC_SIGNED_AAB_PATH) files are supported.
- `AC_APPCENTER_OWNER`: Owner Name. Owner of the app. The app's owner can be identified in its URL, such as `https://appcenter.ms/users/JohnDoe/apps/myapp` for a user-owned app (where **JohnDoe** is the owner) and `https://appcenter.ms/orgs/Appcircle/apps/myapp` for an org-owned app (owner is **Appcircle**).
- `AC_APPCENTER_APPNAME`: App Name. The name of the app. The app's name can be identified in its URL, such as `https://appcenter.ms/users/JohnDoe/apps/myapp` for a user-owned app (where **myapp** is the app name) and `https://appcenter.ms/orgs/Appcircle/apps/myapp` for an org-owned app (owner is **myapp**).

## Optional Inputs

- `AC_APPCENTER_GROUPS`: Group Names. Comma-separated distribution group names
- `AC_APPCENTER_STORE`: Store name. Name of the store(App Store, Google Play, Intune)
- `AC_APPCENTER_RELEASE_NOTES_PATH`: Release Notes. If you use the `Publish Release Notes` component before this step, release-notes.txt will be used as release notes.
- `AC_APPCENTER_MAPPING_PATH`: Android mappings. The path of mapping.txt file. Example: `$AC_REPOSITORY_DIR/build/app/outputs/mapping/release/mapping.txt`
- `AC_APPCENTER_MANDATORY`: Mandatory Update. This parameter specifies whether the update should be considered mandatory or not.
- `AC_APPCENTER_NOTIFY`: Notify Testers. Notify testers of this release.
- `AC_APPCENTER_VERSION`: App Center CLI Version. The latest version will be used if no version is set.
- `AC_APPCENTER_EXTRA`: Extra arguments. Extra command line arguments for appcenter. For example, add `--debug` for verbose logs.
