## Introduction

{{% glossary-term module %}}

- Modules can be imported in any combination or sequence.
- Module imports are recursive; importing Module A can trigger the import of Module B, and so on.
- Modules can provide configuration files and directories, subject to the constraints described in the [merge configuration settings][] section of the documentation.
- External directories, including those from non-Hugo projects, can be mounted to create a [unified file system](g).

