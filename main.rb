# frozen_string_literal: true

require 'English'
require 'os'
require 'pathname'
require 'fileutils'
require 'plist'

def get_env_variable(key)
  ENV[key].nil? || ENV[key] == '' ? nil : ENV[key]
end

def env_has_key(key)
  !ENV[key].nil? && ENV[key] != '' ? ENV[key] : abort("Missing #{key}.")
end

def run_command(cmd)
  puts "@@[command] #{cmd}"
  output = `#{cmd}`
  raise "Command failed. Check logs for details \n\n #{output}" unless $CHILD_STATUS.success?

  output
end

if `which appcenter`.empty?
  puts 'Installing Appcenter CLI'
  cli_version = get_env_variable('AC_APPCENTER_VERSION')
  cli_version = cli_version.nil? ? '' : "@#{cli_version}"
  run_command("npm install -g appcenter-cli#{cli_version}")
end

apk_path = env_has_key('AC_APPCENTER_APK_PATH')
token = env_has_key('AC_APPCENTER_TOKEN')
app_name = env_has_key('AC_APPCENTER_APPNAME')
owner = env_has_key('AC_APPCENTER_OWNER')
app = "#{owner}/#{app_name}"
group = get_env_variable('AC_APPCENTER_GROUPS')
release_notes = get_env_variable('AC_APPCENTER_RELEASE_NOTES_PATH')
mandatory = get_env_variable('AC_APPCENTER_MANDATORY')
notify = get_env_variable('AC_APPCENTER_NOTIFY')
store = get_env_variable('AC_APPCENTER_STORE')
extra = get_env_variable('AC_APPCENTER_EXTRA')
puts "Distributing: #{apk_path}"

cmd = "appcenter distribute release --token #{token} --app #{app} --file #{apk_path}"
cmd += " --release-notes-file #{release_notes}" if release_notes && File.exist?(release_notes)
cmd += " --group #{group}" if group
cmd += " --store #{store}" if store
cmd += ' --silent' if notify == 'false'
cmd += ' --mandatory' if mandatory == 'true'
cmd += " #{extra}" if extra

result =  run_command(cmd)
puts "Distribution report: \n\n #{result}"

mapping_path = get_env_variable('AC_APPCENTER_MAPPING_PATH')
if mapping_path && File.exist?(mapping_path)
  puts "Uploading mappings: #{mapping_path}"
  android_home = env_has_key('ANDROID_HOME')
  version_info = `#{android_home}/aapt dump badging #{apk_path} | grep version`
  version_name = version_info[/versionName='([^']*)'/, 1]
  version_code = version_info[/versionCode='([^']*)'/, 1]

  cmd = "appcenter crashes upload-mappings --mapping #{mapping_path} --token #{token} --app #{app} --version-name #{version_name} --version-code #{version_code}"
  result = run_command(cmd)
  puts "Upload mappings report: \n\n #{result}"
end
