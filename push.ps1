#!/usr/bin/env pwsh
$ErrorActionPreference = "stop"

Write-Host "Building BlogVerse..."

# Detect os
$IsWindows = $env:OS -eq "Windows_NT"

if ($IsWindows) {
	Write-Host "Detected Windows"
	
	# Change Path Here
	$SrcPost = "C:\Users\mruna\Documents\Learnaholic\Blogs & Posts\posts"
	$DstPost = "C:\Users\mruna\Documents\Portfolio\BlogVerse\content\posts"
	
	Write-Host "Syncing posts & images with robocopy..."
	robocopy "$SrcPost" "$DstPost" /mir | Out-Null
} else {
	Write-Error "Unsupported operating system"
}

Write-Host "Running Image processing..."
python images.py

Write-Host "Building Hugo Site"
hugo --gc --minify --baseURL "https://mrunalnshah.github.io/BlogVerse/"

Write-Host "Done!"