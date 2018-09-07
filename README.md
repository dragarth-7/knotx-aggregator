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
   
5. Assuming you have created account on [Docker Hub](https://hub.docker.com/) and you're assigned to the Knot.x organization, add server entry to your `settings.xml` to enable pushing to the docker registry.
```xml
	<server>
		<id>registry.hub.docker.com</id>
		<username>[Username]</username>
		<password>[password]</password>
	</server>
```

6. Bintray account created (to release Knot.x binary distributions)

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

1. Clone repos. (It will do a shallow clone of all repos being a subject of the release procedure)
```bash
sh clone.sh
```

2. Start release & provide the release version number
```bash
sh start-release.sh 1.3.0
```

3. Validate release on staging repos

4. Close the release
```bash
sh close-release.sh 1.3.0 1.3.1-SNAPSHOT <bintrayUser> <bintrayToken>
```

5. TBD: update website - binary distro links
