## Arguments

The function accepts one optional argument: the [context](g). This argument determines the value of the dot (`.`) inside the captured block when it is rendered.

- If you provide an argument, such as `{{ templates.Inner .SomeData }}`, the dot inside the captured block is rebound to that specific data.
- If you do not provide an argument, the captured block uses the context of the caller where the partial was first invoked.

