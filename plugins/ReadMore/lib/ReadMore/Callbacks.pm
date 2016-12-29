package ReadMore::Callbacks;

use strict;
use warnings;
use Encode;
use IO::File;

sub _cb_build_page {
    my ( $cb, %args ) = @_;

    my $mt = MT->instance;
    my $plugin = MT->component( 'ReadMore' );

    my ( $use_charcount, $charcount ) = __get_config( $mt, $mt->param( 'blog_id' ) );

    my $target = '<div class="readmore-link"></div>';
    my $readmore_link_text = $plugin->translate( 'read more' );
    my $result = <<"EOF";
<div class="readmore-link">
    <a href="#readmore">$readmore_link_text</a>
</div>
EOF
    my $individual = $args{ Entry } || $args{ Page };
    if ( ! $individual ) {
        $result = '';
    } else {
        if ( $use_charcount && $charcount > 0 ) {
            $target = $individual->text;
            ${$args{ Content }} =~ s!\Q$target\E!<div id="readmore-wraptext">$target</div>!;

            my $json_fh = new IO::File( sprintf( '%s/plugins/ReadMore/js/meta.js', $mt->config('StaticFilePath') ), 'w' ) or die "$! -- fail to open json file\n";
            my $json = <<"EOF";
var ReadMore = {};

ReadMore.use_charcount = $use_charcount;
ReadMore.charcount = $charcount;
EOF
            print $json_fh $json;
            $json_fh->close;
            my $json = sprintf( '<script type="text/javascript" src="%s/plugins/ReadMore/js/meta.js"></script>', $mt->static_path );
            ${$args{ Content }} =~ s!\Q</body>\E!$json</body>!;
        } else {
            ${$args{ Content }} =~ s!\Q$target\E!$result!;
        }
    }


    my $script = sprintf( '<script type="text/javascript" src="%s/plugins/ReadMore/js/readmore.js"></script>', $mt->static_path );
    ${$args{ Content }} =~ s!\Q</body>\E!$script</body>!;
}

sub __remove_html_tag {
    my ( $html ) = @_;
    my $tag_regex_ = q{[^"'<>]*(?:"[^"]*"[^"'<>]*|'[^']*'[^"'<>]*)*(?:>|(?=<)|$(?!\n))};
    my $comment_tag_regex =  '<!(?:--[^-]*-(?:[^-]+-)*?-(?:[^>-]*(?:-[^>-]+)*?)??)*(?:>|$(?!\n)|--.*$)';
    my $tag_regex = qq{$comment_tag_regex|<$tag_regex_};
    $html =~ s!$tag_regex!!og;
    return $html;
}

sub __get_config {
    my ( $app, $blog_id ) = @_;
    my $plugin = MT->component( 'ReadMore' );
    my ( $use_charcount, $charcount );
    my $blog;
    if ( $blog_id ) {
        $blog = MT::Blog->load( $blog_id );
    } else {
        if ( $blog = $app->blog ) {
            $blog_id = $blog->id;
        }
    }
    if ( $blog ) {
        $use_charcount  = $plugin->get_config_value( 'readmore_use_charcount', 'blog:' . $blog->id );
        $charcount = $plugin->get_config_value( 'readmore_charcount', 'blog:' . $blog->id );
        if ( (! $use_charcount ) && (! $charcount ) ) {
            if ( $blog->class eq 'blog' ) {
                $use_charcount  = $plugin->get_config_value( 'readmore_use_charcount', 'blog:' . $blog->parent_id );
                $charcount = $plugin->get_config_value( 'readmore_charcount', 'blog:' . $blog->parent_id );
            }
        }
    }
    if ( (! $use_charcount ) && (! $charcount ) ) {
        $use_charcount  = $plugin->get_config_value( 'readmore_use_charcount' );
        $charcount = $plugin->get_config_value( 'readmore_charcount' );
    }
    return ( $use_charcount, $charcount );
}

1;
