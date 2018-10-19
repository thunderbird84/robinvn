#!/usr/bin/ruby
require 'yaml'
require 'etc'
require 'fileutils'


class App
   class << self 
    def main(args)   
        if args.length < 2 then
            puts "jjp create PrjectName"
            Process.exit(0)
        end        

        createJavaProject(args[1])
    end

    def createJavaProject(projectName)

        [ "#{projectName}/src/main/java",
          "#{projectName}/src/main/resources",
          "#{projectName}/src/test/java",
          "#{projectName}/src/test/resource",
        ].each do |dir|
            FileUtils.mkdir_p(dir) unless File.exists?(dir)
        end 
        
        [ "#{projectName}/src/main/resources/log4j.properties",         
          "#{projectName}/src/test/resource/log4j.properties",
        ].each do |file|
            File.open(file, 'w') { |file| file.write('') } unless File.file?(file)
        end
        

        content = %{
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>robinvn</groupId>
    <artifactId>#{projectName}</artifactId>
    <packaging>jar</packaging>
    <version>1-SNAPSHOT</version>
    <name>${project.artifactId}</name>

    <properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
   </properties>

<dependencies>
    <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
    </dependency>
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
        pomFile = "#{projectName}/pom.xml"
        File.open(pomFile, 'w') { |file| file.write(content) } unless File.file?(pomFile)
    end     

   end 
end 

#exec main
App.main(ARGV)