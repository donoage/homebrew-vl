# Volume Leaders Command-line Tool

This directory contains the script for the `vl` command-line tool.

## Development

If you make changes to the script:

1. Test your changes locally
2. When you push to GitHub, the GitHub Actions workflow will:
   - Update the SHA256 checksum in the formula if needed
   - Create a new release if the version has changed
   - The new release will automatically be available via Homebrew

## Release Process

The release process is automated via GitHub Actions. When you update the script:

1. The SHA256 checksum is automatically calculated and updated in the formula
2. A new tag and release are created on GitHub
3. The formula is updated to point to the new release

## Manual Testing

```bash
# Run locally before committing
chmod +x vl
./vl --help
```
