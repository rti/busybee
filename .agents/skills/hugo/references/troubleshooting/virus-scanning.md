## Virus scanning

Virus scanners are an essential component of system protection, but the performance impact can be severe for applications like Hugo that frequently read and write to disk. For example, with Microsoft Defender Antivirus, build times for some sites may increase by 400% or more.

Before building a site, your virus scanner has already evaluated the files in your project directory. Scanning them again while building the site is superfluous. To improve performance, add Hugo's executable to your virus scanner's process exclusion list.

For example, with Microsoft Defender Antivirus:

**Start**&nbsp;> **Settings**&nbsp;> **Privacy&nbsp;&&nbsp;security**&nbsp;> **Windows&nbsp;Security**&nbsp;> **Open&nbsp;Windows&nbsp;Security**&nbsp;> **Virus&nbsp;&&nbsp;threat&nbsp;protection**&nbsp;> **Manage&nbsp;settings**&nbsp;> **Add&nbsp;or&nbsp;remove&nbsp;exclusions**&nbsp;> **Add&nbsp;an&nbsp;exclusion**&nbsp;> **Process**

Then type `hugo.exe` add press the **Add** button.

> [!NOTE]
> Virus scanning exclusions are common, but use caution when changing these settings. See the [Microsoft Defender Antivirus documentation][] for details.

Other virus scanners have similar exclusion mechanisms. See their respective documentation.

