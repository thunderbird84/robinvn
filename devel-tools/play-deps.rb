#!/usr/bin/ruby
require 'yaml'
require 'etc'
require 'fileutils'

playDeps = YAML.load_file('conf/dependencies.yml')
rex = /([^\s]*)\s*->\s*([^\s]*)\s+([^\s]*)/
jars = Array.new
playDeps['require'].each do  |jar|
  if jar.class == String && rex.match(jar)
    groupId, artifactId, version = rex.match(jar).captures
    jars.push({'groupId' => groupId, 'artifactId' => artifactId, 'version' => version})
  elsif jar.class == Hash && jar.first[0].class == String
   groupId, artifactId, version = rex.match(jar.first[0]).captures
   jars.push({'groupId' => groupId, 'artifactId' => artifactId, 'version' => version})
  end
end


jars.each do |jar|
  unless jar['groupId'] == 'play'
    ivyCache = "#{Etc.getpwuid.dir}/.ivy2/cache/#{jar['groupId']}/#{jar['artifactId']}"
    FileUtils.rm_rf(ivyCache)
  end
end

content =''
jars.each do |jar|
  unless jar['groupId'] == 'play'
   content = content + %{
     <dependency>
            <groupId>#{jar['groupId']}</groupId>
            <artifactId>#{jar['artifactId']}</artifactId>
            <version>#{jar['version']}</version>
     </dependency>
   }
  end
end

content = %{
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>play-deps</groupId>
    <artifactId>play-deps</artifactId>
    <packaging>pom</packaging>
    <version>1-SNAPSHOT</version>
    <name>${project.artifactId}</name>
<dependencies>
  #{content}
</dependencies>
<build>
        <plugins>
          <plugin>
            <artifactId>maven-dependency-plugin</artifactId>
            <executions>
              <execution>
                <phase>install</phase>
                <goals>
                  <goal>copy-dependencies</goal>
                </goals>
                <configuration>
                  <outputDirectory>${project.basedir}/lib</outputDirectory>
                </configuration>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
</project>
}

File.open('.play-deps.xml', 'w') { |file| file.write(content) }


#
# pids = []
# jars.each do |jar|
#   unless jar['groupId'] == 'play'
#     cmd = "mvn dependency:get -Dartifact=#{jar['groupId']}:#{jar['artifactId']}:#{jar['version']}"
#     pids << Process.fork { system cmd }
#   end
# end
#
# pids.each {|pid| Thread.new { Process.waitpid(pid) }.join }