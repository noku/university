package com.company;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;

/**
 * Created by peter on 11/26/14.
 */
public class Newyorker extends NewsHandler {

    @Override
    int result() throws IOException {
        Document doc = Jsoup.connect(link).get();
        Elements paragraphs = doc.select(".articleBody p");
        for (org.jsoup.nodes.Element element : paragraphs) {
            numberOfWords += countWords(element.text());
        }
        return numberOfWords;
    }
}
