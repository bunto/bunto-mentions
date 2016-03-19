# Bunto Mentions

@mentionable support for your Bunto site

[![Gem Version](https://badge.fury.io/rb/bunto-mentions.png)](http://badge.fury.io/rb/bunto-mentions)
[![Build Status](https://travis-ci.org/bunto/bunto-mentions.svg?branch=master)](https://travis-ci.org/bunto/bunto-mentions)

## Usage

Add the following to your site's `Gemfile`

```
gem 'bunto-mentions'
```

And add the following to your site's `_config.yml`

```yml
gems:
  - bunto-mentions
```

In any page or post, use @mentions as you would normally, e.g.

```markdown
Hey @SuriyaaKudoIsc, what do you think of this?
```

**Note**: Bunto Mentions simply turns the @mentions into links, it does not notify the mentioned user.

## Configuration

Have your own social network? No problem. We allow you to configure the base URL of all the mentions.

To change it, add the following to your Bunto configuration:

```yaml
bunto-mentions:
  base_url: https://twitter.com
```

If you're lazy like me, you can use this shorthand:

```yaml
bunto-mentions: https://twitter.com
```

An example of Twitter mentions using bunto-mentions: 

```yaml
gems:
  - bunto-mentions

bunto-mentions:
  base_url: https://twitter.com
```  

Et voilà! Your mentions will now use that base URL instead of the default of `https://github.com`.
