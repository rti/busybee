## Sort order

Use the following rules to understand how Hugo sorts the collection returned by the `Rotate` method.

| Dimension | Primary Sort | Secondary Sort |
| :--- | :--- | :--- |
| Language | Weight ascending | Lexicographical ascending |
| Version | Weight ascending | Semantic version descending |
| Role | Weight ascending | Lexicographical ascending |

