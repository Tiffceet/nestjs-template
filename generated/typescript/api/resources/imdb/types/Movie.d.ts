/**
 * This file was auto-generated by Fern from our API Definition.
 */
import * as MyapiApi from "../../..";
export interface Movie {
    id: MyapiApi.MovieId;
    title: string;
    /** The rating scale out of ten stars */
    rating: number;
}
