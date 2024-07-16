{
  # yes this is very silly
  # but it makes sure actionlint won't lint *every* yaml file
  filetype.pattern = {
    ".*/.github/workflows/.*%.yml" = "yaml.githubaction";
    ".*/.github/workflows/.*%.yaml" = "yaml.githubaction";
  };
}
