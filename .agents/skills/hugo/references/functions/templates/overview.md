## Overview

The `templates.Inner` function acts as a placeholder within a partial template. When a partial is called as a decorator, it captures a block of code from the calling template rather than rendering it immediately. The `templates.Inner` function tells Hugo exactly where to inject that captured content.

This signals a reversal of execution where the callee becomes the caller. The partial manages the outer structure while the calling template remains in control of the inner content.

