### GitHubbub!  GitHub Does Not Value Software Freedom.

<div class="inline-img">![GitHub](/images/github-mark-large.png "GitHubbub!")</div>

If you hit this page expecting to have been taken to my GitHub profile, then
this is probably not what you were looking for.  But let me tell you why
you're here.

Before providing a link to something hosted on a service, it is wise to
consider whether doing so is a good idea---whether the service or website
is antithetical to the message you are trying to send to your
readers/visitors, or whether it deserves clarification.  There's a little
bit of both here.


#### Non-Free JavaScript
[Free software][freesw] guarantees your freedom to study, modify, and share
the software that you use.  We value these freedoms on the desktop, so why
should we compromise when websites serve proprietary JavaScript
[just because it creates the illusion of remote execution][whyfreejs]?  When
you visit a website that serves JavaScript to the client, your web browser
is automatically [downloading and executing (often without your permission)
untrusted software][jstrap].  If that JavaScript is not
[freely licensed][librejs], then the software running in your web browser
is proprietary.

**When you visit `github.com`, you download over 200kB of obfuscated code,
much of which is proprietary.**  This code provides many website features
that are fairly essential, and *do not work with JavaScript disabled*:

- Change repository names or descriptions;
- Delete repositories;
- Add an SSH key to your account;
- Fork repositories;
- Create pull requests;
- Enable and disable project features;
- Use the wiki and issue trackers;
- View graphs of statistics;
- And others.

That is---GitHub forces you to run proprietary software in order to use much
of their website.  This is unethical.

#### Desire To Remain Non-Free
I contacted GitHub back in April 2014, pointing out these concerns and
asking if they would be able to either liberate their JavaScript, or make
GitHub's essential functionality work without JavaScript enabled.  The first
response I received was from one of their "JavaScript Developers":

> Hi Mike,
> 
> Thanks for getting in touch with us here. Some of our internal projects are
> specific to running GitHub, and as such will probably remain closed. We do
> make an effort to open source projects that we create that we think would be
> beneficial to the community, some of which is JavaScript.
> 
> You can see a list of some of the open source projects that power GitHub
> here:
> 
> https://github.com/showcases/projects-that-power-github

This response is unfortunately misguided: yes, it is good that GitHub
produces free software, but it is a false assumption that their proprietary
code would serve no benefit to the community: the very existence of
their proprietary software
[gives them unjust control over their users][unjust].  Relinquishing that
control is of benefit to the community.

I replied to the above message, clarifying my point.  After receiving no
response, I forwarded the e-mail to GitHub's original founders: [Tom
Preston-Werner][tom], [Chris Wanstrath][chris], and [PJ Hyett][pj].  The
response I received from Chris was blunt and discouraging:

> Hey Mike,
> 
> We have no plans to release github.com's JavaScript as free software at
> this time, nor do we have plans to remove the site's dependence on
> JavaScript. Thanks for the interest.

The original correspondence is provided here:

1. [Original request][gh-request] to `support@github.com`, Tom, Chris, and
  PJ.
2. [Reply to my original request][gh-request-reply] from one of the developers.
3. [My reply to the developer][gh-request2] providing more information and
   asking for a commitment.
4. [Forward of my reply][gh-request3] to Tom, Chris, and PJ, after having
  received no response from the developer.
5. [Response from Chris Wanstrath][gh-request3-reply] stating that GitHub
   has "no plans" to liberate its JavaScript or "remove the site's
   dependence on JavaScript".


[freesw]: https://www.gnu.org/philosophy/free-sw.html
[whyfreejs]: https://www.gnu.org/software/easejs/whyfreejs.html
[jstrap]: https://www.gnu.org/philosophy/javascript-trap.html
[librejs]: https://www.gnu.org/software/librejs/free-your-javascript.html
[unjust]: https://www.gnu.org/philosophy/free-software-even-more-important.html
[tom]: https://github.com/mojombo
[chris]: https://github.com/defunkt
[pj]: https://github.com/pjhyett

[gh-request]: /docs/gh/email-request
[gh-request-reply]: /docs/gh/email-request-reply
[gh-request2]: /docs/gh/email-request2
[gh-request3]: /docs/gh/email-request3
[gh-request3-reply]: /docs/gh/email-request3-reply
