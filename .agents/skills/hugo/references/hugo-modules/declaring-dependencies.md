## Declaring dependencies

Each module declares its Node dependencies in a `package.json` file in its root directory, using the standard `dependencies` and `devDependencies` fields.

<!-- TODO
In the admonition below, remove the reference to v0.159.0 somewhere
after v0.174.0, 15 minor releases after the improvement.
-->

> [!NOTE]
> We improved this setup greatly in Hugo [v0.159.0][], but we kept the old `package.hugo.json` in the search path. Mostly to preserve as much backward compatibility as possible, but it may also be useful in some situations to reserve a separate set of Node dependencies for Hugo.

