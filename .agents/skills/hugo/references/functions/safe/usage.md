## Usage

Use the `safe.URL` function to encapsulate a known safe URL or URL substring. Schemes other than the following are considered unsafe:

- `http:`
- `https:`
- `mailto:`

Use of this type presents a security risk: the encapsulated content should come from a trusted source, as it will be included verbatim in the template output.

See the [Go documentation][] for details.

