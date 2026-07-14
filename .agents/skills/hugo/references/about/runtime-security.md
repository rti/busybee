## Runtime security

Hugo generates static websites, meaning the final output runs directly in the browser and interacts with any integrated APIs. However, during development and site building, the `hugo` executable itself is the runtime environment.

Securing a runtime is a complex task. Hugo addresses this through a robust sandboxing approach and a strict security policy with default protections. Key features include:

- Virtual file system: Hugo employs a virtual file system, limiting file access. Only the main project, not external components, can access files or directories outside the project root.
- Read-Only access: User-defined components have read-only access to the file system, preventing unintended modifications.
- Controlled external binaries: While Hugo utilizes external binaries for features like Asciidoctor support, these are strictly predefined with specific flags and are disabled by default. The [security policy][] details these limitations.
- No arbitrary commands: To mitigate risks, Hugo intentionally avoids implementing general functions that would allow users to execute arbitrary operating system commands.
- Pragmatic defaults: The default [security policy][] aims to balance security and usability, enabling common workflows out of the box while keeping more sensitive capabilities opt-in. These defaults may be tightened in future releases, but each project is ultimately responsible for reviewing the policy and adjusting it to match its own trust model and requirements.

This combination of sandboxing and strict defaults effectively minimizes potential security vulnerabilities during the Hugo build process.

