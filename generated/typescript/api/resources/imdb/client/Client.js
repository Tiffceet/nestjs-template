"use strict";
/**
 * This file was auto-generated by Fern from our API Definition.
 */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Imdb = void 0;
const core = __importStar(require("../../../../core"));
const MyapiApi = __importStar(require("../../.."));
const serializers = __importStar(require("../../../../serialization"));
const url_join_1 = __importDefault(require("url-join"));
const errors = __importStar(require("../../../../errors"));
class Imdb {
    constructor(_options) {
        this._options = _options;
    }
    /**
     * Add a movie to the database
     */
    createMovie(request) {
        return __awaiter(this, void 0, void 0, function* () {
            const _response = yield core.fetcher({
                url: (0, url_join_1.default)(yield core.Supplier.get(this._options.environment), "/movies/create-movie"),
                method: "POST",
                headers: {
                    "X-Fern-Language": "JavaScript",
                },
                contentType: "application/json",
                body: yield serializers.CreateMovieRequest.jsonOrThrow(request, { unrecognizedObjectKeys: "strip" }),
                timeoutMs: 60000,
            });
            if (_response.ok) {
                return yield serializers.MovieId.parseOrThrow(_response.body, {
                    unrecognizedObjectKeys: "passthrough",
                    allowUnrecognizedUnionMembers: true,
                    allowUnrecognizedEnumValues: true,
                    breadcrumbsPrefix: ["response"],
                });
            }
            if (_response.error.reason === "status-code") {
                throw new errors.MyapiApiError({
                    statusCode: _response.error.statusCode,
                    body: _response.error.body,
                });
            }
            switch (_response.error.reason) {
                case "non-json":
                    throw new errors.MyapiApiError({
                        statusCode: _response.error.statusCode,
                        body: _response.error.rawBody,
                    });
                case "timeout":
                    throw new errors.MyapiApiTimeoutError();
                case "unknown":
                    throw new errors.MyapiApiError({
                        message: _response.error.errorMessage,
                    });
            }
        });
    }
    /**
     * Retrieve a movie from the database based on the ID
     * @throws {@link MyapiApi.MovieDoesNotExistError}
     */
    getMovie(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const _response = yield core.fetcher({
                url: (0, url_join_1.default)(yield core.Supplier.get(this._options.environment), `/movies/${yield serializers.MovieId.jsonOrThrow(id)}`),
                method: "GET",
                headers: {
                    "X-Fern-Language": "JavaScript",
                },
                contentType: "application/json",
                timeoutMs: 60000,
            });
            if (_response.ok) {
                return yield serializers.Movie.parseOrThrow(_response.body, {
                    unrecognizedObjectKeys: "passthrough",
                    allowUnrecognizedUnionMembers: true,
                    allowUnrecognizedEnumValues: true,
                    breadcrumbsPrefix: ["response"],
                });
            }
            if (_response.error.reason === "status-code") {
                switch (_response.error.statusCode) {
                    case 404:
                        throw new MyapiApi.MovieDoesNotExistError(yield serializers.MovieId.parseOrThrow(_response.error.body, {
                            unrecognizedObjectKeys: "passthrough",
                            allowUnrecognizedUnionMembers: true,
                            allowUnrecognizedEnumValues: true,
                            breadcrumbsPrefix: ["response"],
                        }));
                    default:
                        throw new errors.MyapiApiError({
                            statusCode: _response.error.statusCode,
                            body: _response.error.body,
                        });
                }
            }
            switch (_response.error.reason) {
                case "non-json":
                    throw new errors.MyapiApiError({
                        statusCode: _response.error.statusCode,
                        body: _response.error.rawBody,
                    });
                case "timeout":
                    throw new errors.MyapiApiTimeoutError();
                case "unknown":
                    throw new errors.MyapiApiError({
                        message: _response.error.errorMessage,
                    });
            }
        });
    }
}
exports.Imdb = Imdb;
