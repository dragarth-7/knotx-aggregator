# Release process

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
TBD
- Get the knotx-stack-manager-{VER}.zip from central or from target/ and upload to bintray
- Update the knotx.io download page ???

## Release TBD module

