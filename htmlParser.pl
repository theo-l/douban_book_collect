#!/perl -w
use strict;
use HTML::TreeBuilder;
use LWP::Simple;

my $url="http://book.douban.com/subject_search?search_text=6%E5%8F%B7%E7%89%B9%E5%B7%A5&cat=1003";
my $doc=get($url);
open DATA,"<",\$doc;

my @dom=<DATA>;
my $html=join "",@dom;
my @tr=get_element_by_attr_regex($html,'class',qr/item/);
print scalar @tr,"\n";
 for(@tr){
	 use 5.012;
	 use Data::Dumper;
#	 say Dumper($_);
 }


sub get_element_by_attr_regex{
	my ($html,$attr,$attr_regex)=@_;
	my $tree=new HTML::TreeBuilder;
	$tree->parse_content($html);
	my @list=$tree->look_down($attr,$attr_regex);
	return @list;
}
#$html: a html content  
#$idvalue: id value  
#  

sub get_element_by_id{  
    my ($html, $idvalue) =@_;  
    my $tree = new HTML::TreeBuilder;  
    $tree->parse_content($html);  
    my @list = $tree->look_down('id',$idvalue);  
    die "not unique element by id:$idvalue" if scalar(@list) != 1;  
    return $list[0];  
}  
#$html: a html content  
#$tagname: tag name  
#  

sub get_elements_by_tag_name{  
    my ($html, $tagname) =@_;  
    my $tree = new HTML::TreeBuilder;  
    $tree->parse_content($html);  
    return $tree->find_by_tag_name($tagname);  
} 

#$html: a html string  
#$tag:  tag name  
#$attr: attr name  
#$attr_regex: attr value pattern  
sub get_elements{  
    my ($html, $tag, $attr, $attr_regex) = @_;  
    my @list = get_elements_by_attr_regex($html, $attr, $attr_regex);  
    $tag = lc $tag;  
    @list = grep $_->tag() eq $tag, @list;  
    return @list;  
}  

