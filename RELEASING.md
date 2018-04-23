# Release process

## Prerequisites
1. Sonatype.org [JIRA](https://issues.sonatype.org/secure/Signup!default.jspa) account

2. Your Sonatype.org account needs to be added to the Knot.x project (if it isn't, please contact the Knot.x team: 
[knotx.team@gmail.com](email:knotx.team@gmail.com))

3. A GPG key generated for the email you have registered on the Sonatype.org JIRA 
(Follow the [Working with PGP Signatures](http://central.sonatype.org/pages/working-with-pgp-signatures.html) 
guide to get one). 
**Don't forget to deploy your public key to the key server!** 

4. Add a `<server>` entry to [your `settings.xml` file](https://maven.apache.org/settings.html#Introduction)
   ```xml
   <servers>
     ...
     <server>
       <id>ossrh</id>
       <username>your_sonatype_org_jira_username</username>
       <password>your_sonatype_org_jira_password</password>
     </server>
       ...
   </servers>    
   ```


## Procedure

1. Clone repos
```bash
sh clone.sh
```



TBD:
docker:push of images
push knotx distro to bintray

update website

# Validate release on staging repos

## If release is ok
Execute on each repo inside `knotx-repos`
```
$> git add .
$> git commit -m "Releasing X.Y.Z"
$> git tag X.Y.Z
$> mvn nexus-staging:release
$> mvn versions:set -DnewVersion=X.Y.NEXT-SNAPSHOT -DgenerateBackupPoms=false
$> git add .
$> git commit -m "Set new development version X.Y.NEXT-SNAPSHOT"
```

## If release is not OK
```
$> cd knotx-repos/knotx-dependencies
$> mvn nexus-staging:drop
```






## Release knotx-dependencies

```
git clone git@github.com:Knotx/knotx-dependencies.git
cd knotx-dependencies
mvn versions:set -DnewVersion=X.Y.Z -DgenerateBackupPoms=false

mvn deploy -Poss-release
git add .
git commit -m "Releasing X.Y.Z"
git tag X.Y.Z
git push
```

## Release knot.x
Follow the [Knot.x Release process](https://github.com/Cognifide/knotx/blob/master/RELEASING.md)

## Release knotx-stack
```
git clone git@github.com:Knotx/knotx-stack.git
cd knotx-stack
mvn versions:set -DnewVersion=X.Y.Z -DgenerateBackupPoms=false

mvn deploy -Poss-release -DskipTests -Dgpg.passphrase="my pass phrase" -DaltDeploymentRepository=local::default

git add .
git commit -m "Releasing X.Y.Z"
git tag X.Y.Z
```

## Release Knot.x distribution
Distributing files via Bintray includes three steps: creating a version, uploading the files and publishing the files.
Creating a version: Uploaded files are associated with a specific version of a package.
Some upload methods can create the version automatically as part of the upload; with other methods you will need to create a target version from the Bintray UI or using REST.
Uploading: Upload your files using one of the methods described in the "Uploading" section.
After uploading your files, the files have a status of "un-published". This means that in the Bintray UI they are only visible to you and can only be downloaded with your username and API Key.
You may discard all or some of your uploaded files when they are "un-published", before anyone sees or downloads them.
Publishing: Once you are good to go, you can publish your files and make them visible and available to all Bintray users.
Publishing can be done via REST (as part of the upload or separately) or using the UI (an unpublished content notice appears on your screen, with links to publish or discard the files).
Some upload methods also allow you to publish your files automatically upon uploading, letting you skip the publishing step.


curl -T knotx-X.Y.Z.zip -u<USER>:<API_KEY> https://api.bintray.com/content/knotx/downloads/distro/X.Y.Z/knotx-X.Y.Z.zip

curl -T knotx-X.Y.Z.tar.gz -u<USER>:<API_KEY> https://api.bintray.com/content/knotx/downloads/distro/X.Y.Z/knotx-X.Y.Z.tar.gz


TBD
- Get the knotx-stack-manager-{VER}.zip from central or from target/ and upload to bintray
- Update the knotx.io download page ???

## Release TBD module

