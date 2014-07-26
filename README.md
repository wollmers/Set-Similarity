# NAME

Set::Similarity - similarity measures for sets

# SYNOPSIS

    use Set::Similarity::Dice;
    
    # object method
    my $dice = Set::Similarity::Dice->new;
    my $similarity = $dice->similarity('Photographer','Fotograf');
    
    # class method
    my $dice = 'Set::Similarity::Dice';
    my $similarity = $dice->similarity('Photographer','Fotograf');
    
    # from 2-grams
    my $width = 2;
    my $similarity = $dice->similarity('Photographer','Fotograf',$width);
    
    # from arrayref of tokens
    my $similarity = $dice->similarity(['a','b'],['b']);
    
    # from hashref of features
    
    # from arrayref sets
    

    

# DESCRIPTION

## Overlap coefficient

( A intersect B ) / min(A,B)

## Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both molecules to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard 

The range is 0 to 1 inclusive.

## Dice coefficient

The Dice coefficient is the number of features in common to both molecules relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

# METHODS

## new

    $object = Set::Similarity->new();

## similarity

    my $similarity = $object->similarity('a','b');
    

## from\_tokens

    my $similarity = $object->from_tokens(['a'],['b']);

## from\_sets

    my $similarity = $object->from_sets({'a' => undef},{'b' => undef});

## intersection

    my $intersection_size = $object->intersection({'a' => undef},{'b' => undef});
    

## combined\_length

    my $set_size_sum = $object->combined_length({'a' => undef},{'b' => undef});

## min

    my $min_set_size = $object->min({'a' => undef},{'b' => undef});
    

## ngrams

    my $bigrams = $object->ngrams('abc',2);

# SOURCE REPOSITORY

[http://github.com/wollmers/Set-Similarity](http://github.com/wollmers/Set-Similarity)

# AUTHOR

Helmut Wollmersdorfer, <helmut.wollmersdorfer@gmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2013-2014 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
