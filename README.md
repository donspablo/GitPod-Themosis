![](https://miro.medium.com/max/305/0*zf_GZ2XnFpD-YZfs.png)

Getting started with Themosis and Vagrant
=========================================
<a href="https://gitpod.io/#https://github.com/donPabloNow/themosis"><img width="250px" src="https://user-images.githubusercontent.com/6468571/142190677-9676154b-33b6-424b-99cc-f10d88ad030c.png" /></a>

[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/donPabloNow/themosis)

An introduction to the Themosis framework while building a blog website.
------------------------------------------------------------------------

![](https://miro.medium.com/max/30/0*EuoywKype6cuWJqf.png?q=20)

![](https://miro.medium.com/max/623/0*EuoywKype6cuWJqf.png)

![](https://miro.medium.com/max/1920/0*zqFVC8z-TTf6UDpE)

![](https://miro.medium.com/max/481/0*fzLyn-id6fJagkfb.png)

**Covered in this series of articles:**

1.  [Getting started with Vagrant](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-installation-and-configuration-1-8-4732cfca938c?source=your_stories_page----------------------------------------)
2.  [Setting up the Theme](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-setting-up-the-theme-2-8-404ee48b449b?source=your_stories_page----------------------------------------)
3.  [Routing: The basics](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-routing-basics-3-8-8416a7122ab2?source=your_stories_page----------------------------------------)
4.  [Routing: Advanced](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-routing-advanced-4-8-4294fe88d66d?source=your_stories_page----------------------------------------)
5.  [Setup “twentynineteen” assets](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-setup-twentynineteen-assets-5-8-97d641b9dbbf?source=your_stories_page----------------------------------------)
6.  [Custom theme options](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-custom-theme-options-6-8-6fcf00ad915b?source=your_stories_page----------------------------------------)
7.  [WordPress routes](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-wordpress-routes-7-8-92c2e837869b?source=your_stories_page----------------------------------------)
8.  [Wrap Up](https://xn--dn-8bb.com/getting-started-with-the-themosis-framework-wrap-up-8-8-3e992ea3a37?source=your_stories_page----------------------------------------)

GitHub - donPabloNow/themosis: A framework for WordPress developers.
--------------------------------------------------------------------

### The Themosis framework is a tool aimed to WordPress developers of any levels. But the better WordPress and PHP…

github.com

![](https://miro.medium.com/max/30/0*CcwN7e83uY8ZjD80?q=20)

![](https://miro.medium.com/max/700/0*CcwN7e83uY8ZjD80)

![](https://miro.medium.com/max/662/0*TMIEzwPb9dkm4-hB.png)

In order to install a fresh copy of the Themosis framework, you first need to make sure that your machine has PHP 7.1+ installed as well as Composer.

> _At the time of this recording, I even recommend PHP 7.3_

Also, make sure to have NodeJS installed on your computer in order to use the `npm` package manager during assets installation on later tutorial part.

We recommend you to install their [LTS version](https://nodejs.org/en/) if you haven’t yet installed it on your machine.

![](https://miro.medium.com/max/30/0*qiTqjPDehtPgTsQX.png?q=20)

![](https://miro.medium.com/max/592/0*qiTqjPDehtPgTsQX.png)

Create a new project
====================

In order to start a new Themosis framework project, open your terminal or console and run the following command:

composer create-project themosis/themosis my-blog

The composer `create-project` command takes 2 arguments. The first one is the type of project `themosis/themosis` and the second one is the name of the directory where to store the project.

Once the command is complete, a new Themosis framework project is created under a folder named `my-blog`.

> _Initially the create-project command only takes one argument. In our example, if we omit the directory name, composer will store the project into a_ `_themosis_` _folder instead._

![](https://miro.medium.com/max/30/0*4525wRyb9WaeB6Rq.png?q=20)

![](https://miro.medium.com/max/659/0*4525wRyb9WaeB6Rq.png)

Setup local development environment
===================================

The next step is to first setup a local development environment for our application using [Laravel Homestead](https://laravel.com/docs/6.x/homestead).

Laravel Homestead is a Vagrant box that provides you all the necessary tools and software in order to run and test your application. Homestead is running thanks to [Vagrant](https://www.vagrantup.com/), so we first need to make sure it is installed on our machine.

First, install Vagrant by visiting their [download page](https://www.vagrantup.com/downloads.html). Follow on screen steps and then install a virtual machine client. I generally use [VirtualBox](https://www.virtualbox.org/wiki/Downloads), but you can also install other clients like [VMWare](https://www.vmware.com/), [Parallels](https://www.parallels.com/products/desktop/) or [Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v).

Once those softwares are installed on your machine, we need to add the Homestead box to vagrant. Run the following command from your terminal:

vagrant box add laravel/homestead

Here is also a little suggestion, I find it best to install the Vagrant [hostupdater plugin](https://github.com/cogitatio/vagrant-hostsupdater) to let Vagrant automatically update your machine `etc/hosts` file. From your Terminal or Console, simply run the following command:

vagrant plugin install vagrant-hostsupdater

Later on, during the bootstrap of your virtual machine, you will may be asked to enter your machine administrator password in order to let Vagrant update the `etc/hosts` file and let it insert your project domain name.

Now let’s initialize our local development environment. Still from the Terminal or Console, change the directory to the root of your recently created application `my-blog` and run this command:

php vendor/bin/homestead make

The previous command will add the necessary files to your application so we can configure the behavior of Homestead and virtual machine. You should now find a `Homestead.yml` file at the root of your application, open the file.

By default, this Homestead configuration is setup for a Laravel project, so we need to do some tiny changes to make it work. Here is snippet on how your configuration file should look like:

ip: 192.168.10.10  
memory: 2048  
cpus: 1  
provider: virtualbox  
authorize: ~/.ssh/id\_rsa.pub  
keys:  
- ~/.ssh/id\_rsa  
folders:  
-  
map: '/your/local/path/my-blog'  
to: /home/vagrant/code  
sites:  
-  
map: my-blog.test  
to: /home/vagrant/code/htdocs  
databases:  
- homestead  
name: my-blog  
hostname: my-blog

Pay attention to the `sites` property. The `to` value is now pointing to the `htdocs` directory instead of the default `public` folder.

Under the `databases` property, you can define the name for your database. Here we’re keeping the default one but you are free to choose.

Also, in order to connect to the database, Homestead is also defining a database username and password by default. The username is always `homestead` and the password `secret`. We will need this information when defining the values in our environment file later on.

When you work with Homestead, it installs your application into the `/home/vagrant/code` directory by default inside the virtual machine. So if you want to look after your files inside the VM, make sure to `cd` into this path.

Now that your local Homestead/Vagrant configuration is complete, let’s start the virtual machine by running this command:

vagrant up

This command must be run at the root of your application, where the `Vagrantfile` is sitted. The command may take several minutes the first time you’re working with Homestead but don’t worry and let it run until completion.

> _When you want to stop working on your application, you can stop the virtual machine by running the_ `_vagrant halt_` _command._

Now that our virtual machine is launched and our local development is running, let’s first install a new theme, setup our application environment and install WordPress.

![](https://miro.medium.com/max/30/0*AepgCWFnw83xPHjr.png?q=20)

![](https://miro.medium.com/max/700/0*AepgCWFnw83xPHjr.png)

_Connect with me @donPabloNow on these other great platforms:_

[_BANDLAB_](https://www.bandlab.com/donpablonow) _|_ [_DISPLAY_](http://Hey,%20come%20join%20me%20at%20Display,%20the%20social%20that%20pays!%20%20%20Tell%20them%20@donpablonow%20sent%20you.%20%20%20https//tsu.onelink.me/znrO?pid=af_app_invites&af_dp=tsuapp%3A%2F%2F&af_referrer_customer_id=746609&c=746609&af_referrer_name=donPabloNow&af_referrer_uid=746609&af_channel=tsu&af_referrer_image_url=https%3A%2F%2Fd2wutw6b039ws8.cloudfront.net%2Fusers%2Favatars%2F000%2F746%2F609%2Flarge%3F1630586132&af_siteid=social.tsu.android&is_retargeting=true&deep_link_value=746609) _|_ [_LOUDLY_](https://www.loudly.com/community/profiles/donpablonow) _|_ [_DRIBBLE_](https://dribbble.com/donpablonow) _|_ [_PINTREST_](https://www.pinterest.com/donPabloNow/) _|_ [_INSTAGRAM_](https://www.instagram.com/donpablonow/) _|_ [_GITHUB_](https://github.com/donPabloNow) _|_ [_FACEBOOK_](https://www.facebook.com/donpablonow) _|_ [_YOUTUBE_](https://www.youtube.com/c/donpablonow) _|_ [_TWITTER_](https://twitter.com/donPabloNow) _|_ [_LINKEDIN_](https://www.linkedin.com/in/donPabloNow/) _|_ [_TIKTOK_](https://www.tiktok.com/@donpablonow) _|_ [_CODEPEN_](https://codepen.io/donPabloNow) _|_ [_SOUNDCLOUND_](https://soundcloud.com/pablo-brincat) _|_ [_SPOTIFY_](https://open.spotify.com/user/21dhvyi7f7u6ozs7irfp2hkiy) _|_ [_SUSE_](https://community.suse.com/members/8757642) _|_ [_VERCEL_](https://vercel.co/donPabloNow)

[![Build Status](https://travis-ci.org/themosis/themosis.svg?branch=dev)](https://travis-ci.org/themosis/themosis)

The Themosis framework is a tool aimed to WordPress developers of any levels. But the better WordPress and PHP knowledge you have the easier it is to work with.

Themosis framework is a tool to help you develop websites and web applications faster using [WordPress](https://wordpress.org). Using an elegant and simple code syntax, Themosis framework helps you structure and organize your code and allows you to better manage and scale your WordPress websites and applications.

Installation
------------
Please see the [installation section](https://framework.themosis.com/docs/master/installation/) of the Themosis documentation.

Development team
----------------
The framework was created by [Julien Lambé](https://www.themosis.com/), who continues to lead the development.

Contributing
------------
Any help is appreciated. The project is open-source and we encourage you to participate. You can contribute to the project in multiple ways by:

- Reporting a bug issue
- Suggesting features
- Sending a pull request with code fix or feature
- Following the project on [GitHub](https://github.com/donpablonow/themosis)
- Following us on Twitter: [@Themosis](https://twitter.com/Themosis)
- Sharing the project around your community

For details about contributing to the framework, please check the [contribution guide](https://framework.themosis.com/docs/master/contributing).

License
-------
The Themosis framework is open-source software licensed under [GPL-2+ license](http://www.gnu.org/licenses/gpl-2.0.html).