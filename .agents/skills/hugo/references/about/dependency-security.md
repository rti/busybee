## Dependency security

Hugo utilizes [Go modules][] to manage its dependencies, compiling as a static binary. Go modules create a `go.sum` file, a critical security feature. This file acts as a database, storing the expected cryptographic checksums of all dependencies, including those required indirectly (transitive dependencies).

[Hugo modules][], which extend the functionality of Go modules, also produce a `go.sum` file. To ensure dependency integrity, commit this `go.sum` file to your version control. If Hugo detects a checksum mismatch during the build process, it will fail, indicating a possible attempt to [tamper with your project's dependencies][].

