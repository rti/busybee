## Scale

As you decrease the size of a QR code, the maximum distance at which it can be reliably scanned by a device also decreases.

In the example above, we set the `scale` to `2`, resulting in a QR code where each module consists of 2x2 pixels. While this might be sufficient for on-screen display, it's likely to be problematic when printed at 600 dpi.

\[ \frac{2\:px}{module} \times \frac{1\:inch}{600\:px} \times \frac{25.4\:mm}{1\:inch} = \frac{0.085\:mm}{module} \]

This module size is half of the commonly recommended minimum of 0.170 mm.\
If the QR code will be printed, use the default `scale` value of `4` pixels per module.

Avoid using Hugo's image processing methods to resize QR codes. Resizing can introduce blurring due to anti-aliasing when a QR code module occupies a fractional number of pixels.

> [!NOTE]
> Always test the rendered QR code both on-screen and in print.

