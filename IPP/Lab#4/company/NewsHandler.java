package com.company;

import java.io.IOException;

/**
 * Created by peter on 11/26/14.
 */
abstract class NewsHandler {

    protected String link;
    protected int numberOfWords = 0;
    abstract int result() throws IOException;

    protected NewsHandler receiveLink(String url) {
        link = url;
        return this;
    }

    protected int countWords(String s){
        return s.split("\\s+").length;
    }

}
