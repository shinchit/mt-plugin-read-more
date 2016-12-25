package ReadMore::Callbacks;

use strict;
use warnings;

sub _cb_build_page {
    my ( $cb, %args ) = @_;

    my $mt = MT->instance;
    my $plugin = MT->component( 'ReadMore' );

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
    }
    ${$args{ Content }} =~ s!\Q$target\E!$result!;
    
    my $script = sprintf( '<script type="text/javascript" src="%s/plugins/ReadMore/js/readmore.js"></script>', $mt->static_path );
    ${$args{ Content }} =~ s!\Q</body>\E!$script</body>!;
}

1;
