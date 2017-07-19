Pod::Spec.new do |spec|
  spec.name = "KunstmaanI18nSwift"
  spec.version = "2.2.0"
  spec.summary = "Framework for adding basic Localization to your project."
  spec.homepage = "https://github.com/kunstmaan/i18n-swift"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Kunstmaan" => 'labs@kunstmaan.be' }
  spec.social_media_url = "http://twitter.com/kunstmaan"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/kunstmaan/i18n-swift.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "KunstmaanI18nSwift/**/*.{h,swift}"
end
