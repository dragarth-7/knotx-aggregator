# Development process
This section describes tools that help you with coding. We provide scripts that allows to
clone all repositories and install artifacts to Maven local / Maven Central Snapshot repositories.

## Clone all repositories
Check a `development/pull-all.sh` script to clone all Knot.x repositories. Please check `-h` option
for help.

## Build all repositories
Check a `development/build-all.sh` script to build all cloned repositories. Please check `-h` option
for help.

## Use cases
After cloning the repository on Unix please change permissions:

```
$>git clone git@github.com:Knotx/knotx-aggregator.git
$>chmod -R 755 knotx-aggregator/**/*.sh
```

### Install my changes to M2 repository
From `development` directory run:
```
$>./pull-all.sh -r projects/knotx -b feature/my-changes -m origin/master
$>./build-all.sh -r projects/knotx
```

### Deploy all to Maven Central SNAPSHOT repository
From `development` directory run:
```
$>./pull-all.sh -r projects/knotx -b master -f
$>./build-all.sh -r projects/knotx -d
```

# Release process
This section describes release process.

## Prerequisites
1. Sonatype.org [JIRA](https://issues.sonatype.org/secure/Signup!default.jspa) account

2. Your Sonatype.org account needs to be added to the Knot.x project (if it isn't, please contact the Knot.x team
via [User Group](https://groups.google.com/forum/#!forum/knotx) or [Gitter Chat](https://gitter.im/Knotx/Lobby).

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

5. Assuming you have created account on [Docker Hub](https://hub.docker.com/) and you're assigned to the Knot.x organization, add server entry to your `settings.xml` to enable pushing to the docker registry.
```xml
	<server>
		<id>registry.hub.docker.com</id>
		<username>[Username]</username>
		<password>[password]</password>
	</server>
```

6. Bintray account created (to release Knot.x binary distributions) and token generated.

7. Update your `gradle.properties` with
```
signing.keyId=24875D73
signing.password=secret
signing.secretKeyRingFile=/Users/me/.gnupg/secring.gpg
```
and
```
ossrhUsername=your_sonatype_org_jira_username
ossrhPassword=your_sonatype_org_jira_password
```
For releasing gradle repos.

## Procedure
From the repository top directory execute following commands:

1. Clone repos. (It will do a shallow clone of all repos being a subject of the release procedure)
```bash
sh release/clone.sh
```

2. Start release & provide the release version number
```bash
sh release/start-release.sh 1.5.0
```

3. Validate release on staging repos

4. Release docker image:
```bash
sh release/release-docker.sh knotx-stack/knotx-docker
```

5. Close the release
Create manually new versions for `examples` and `distro` packages at bintray.
Run:
```bash
sh release/close-release.sh 1.5.0 1.5.1-SNAPSHOT <bintrayUser> <bintrayToken>
```

6. Manual actions:
  - close and promote repos released by gradle manually at oss.sonatype.org
  - publish bintray files
  - update website - binary distro links
  - update wiki
  - publish release blog

## ToDo
- automatically close and promote repos released by gradle manually at oss.sonatype.org
- update `knotx-website`
  - binary distro links
  - `index` version
  - produce `blog/release-VERSION/` page that consists of all `CHANGELOG.md` changes for every module
